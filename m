Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65870606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YxFjV0D3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fQ4s2hd/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTS1W-00058p-M6; Tue, 17 Nov 2026 17:51:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTS1R-00056w-5r
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:51:30 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTS1N-00067x-TU
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:51:27 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHMej5Y935097
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 22:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Yyx968y94YFfb/52MmB97SSSbb02LKhcTFVWR/+9ons=; b=YxFjV0D3KmKxfO/n
 fz3QR3dbpwjKji6K1xpU71HMiWhLeQN8FaAbwm/UPviSm+iqSlFCJ7oTrizeZpt5
 JfckFzhU3GRCMdAs6c888SoEkruvpyWRrI3VV3Np73oRxQYNMQp2+reGoxu6j05d
 FhdHjMaTN3gU1/BPTQRf86IHXYAzLJYCN/KN/qWQL2aOwrixj/HqKPgWDDg3o9Uy
 lKiFjkFXf2fXvW/ajt0jLkagZMGRK1VHRw8hCiIMS3ZcLhLgkxIL7jlnGDVdAgC7
 Lhb38RJwE3be4NXUFYKZ1NsluHf/BaPPaC0aBgMu1t9bpi+foup3GatKW5gyyRkf
 40F6AQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv901vd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 22:51:23 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2c0e6653so68526585a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 14:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794955882; x=1795560682; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yyx968y94YFfb/52MmB97SSSbb02LKhcTFVWR/+9ons=;
 b=fQ4s2hd/docajwNwe1RC/9eB74ERoXSh3v4ZGoA+gKDNvC55DHKZRuoI7yEv4nAczs
 YQ5w05UmO3KSTLPjHwZfW5FK6FN3qMll1MJfGJiOIgrxZIDnFEGuqk2SWSPWwgg6SUaz
 ewIIzxL+HeH9kDbhLP/flkiJRndaSrX5vgLwL27nuWfwv5r9qtMVzELyfD1W9BUeFMuF
 IDEJ5dLh03w3fdrPbSKWUC9eBH9U9FJIMC1J6DTnF96FOw7dKPkTZzsxZe5NEzRBRnq3
 xDSOXeDYnbLZ6ZNzFt4Oy52jWsW+zvKwohv75sWS+//18QTpzG7z5J3socIE2pZjVBqz
 AYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794955882; x=1795560682;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yyx968y94YFfb/52MmB97SSSbb02LKhcTFVWR/+9ons=;
 b=XYlFvcboEt/N2wrd64DmvjFLwI+0CfKiJPMRmrwR5m6XgR11hDvLWNNeWg3kopJ0yD
 pU9X3ZesK3aDP4t0C62H/h/iwVTyzbqwArJNkKZ2CvMpGaLHjM0WW1HMbNaJ+K1N1CvO
 Hwn83JrH//omN0JQ/hAtg+nTSOaZcAbmzhZD+q+sB6vFk90eTl/aGEi2MT7Zz3H9mMP3
 IGZGmdhbr5+w8dhSEwkaqBnRk93PR8dZpA8AIm0vic9RIlVPASu//tUyxpsVoyvUCKHR
 N/5x7oKJ9jiYcILlUIjsBhBx8vaD2AykRVOcdLOZydDkBwrConV+Zerxsi7+hxMnHaTa
 A4hw==
X-Forwarded-Encrypted: i=1;
 AL+hErFrJAKUmNo5CB3UDGfnpreDPXu+0YSwmYLxHas9KZG1TAbh/97/sb9RUSXWeXWY7cEcrLlAkCPmNNAy@nongnu.org
X-Gm-Message-State: APuU4Z+oqDcVbYzyY0hNd1seCR77pLemx0kYjFRPFv14U3YYZvwMoLOF
 qWtgxy9X9hebzzvewHFhN0WWfzQt3A0PSPmE/vMRpFwa9DsoSDZwGiYK3xLXzjN7GpMizLdDmuT
 G9oHKD3aJVLM4RKN7COaTEmHDYIQ0psvz2NtKGeygzVWBegIJOq+I9AYchw==
X-Gm-Gg: AYBFou1R+cC0Ti9LsW9EuoP7CsViklR8aimW51QCaw4vI/2ywUMFDhnz3iFJt66Ts3L
 15+1iWCFqz6JI2k2iXkPM/7LzsM1FIDMZmT4e52ATNt9KH/VU1Q+I8BAS28dRT8IpHrx6x4n7ht
 rxMvemnTr2Rqpde0qj/xreowoZ4OoKX6+Ja88HksAlWPg/HX307e7CGMvVt9KeHsbp1IXVmrlwl
 m/RqsWJAQThTWKkTiB76CcMDCkEBYIxF4VFUaO0XJBOQs33rqzoUbjatsBTuaCt77YcZp+ClGbY
 S4mCYbGsbRDNhcEYzOtjnDl9hGJEcnTzSN9VzTXt8dhGcRWbuDnwZukLBp6xDqdyf/4EYFSrHgR
 keLC4iVV/1KP8SBD4LRzDDatpX+ipM05exThaiGRMhHG3fq72tDt2thtUSpDHUrgM88rZHvRfIa
 R2ohC+5VY=
X-Received: by 2002:a05:620a:470a:b0:949:76ca:ff3a with SMTP id
 af79cd13be357-94999762d82mr186748485a.38.1794955882429; 
 Tue, 17 Nov 2026 14:51:22 -0800 (PST)
X-Received: by 2002:a05:620a:470a:b0:949:76ca:ff3a with SMTP id
 af79cd13be357-94999762d82mr186743485a.38.1794955881812; 
 Tue, 17 Nov 2026 14:51:21 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb784231basm98291055e9.11.2026.11.17.14.51.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 14:51:21 -0800 (PST)
Message-ID: <d4e8561b-fe20-4404-953e-75df80976605@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 23:51:19 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/19] target/mips: Fix nanoMIPS BLTUC with rs == $zero
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-15-philmd@oss.qualcomm.com>
 <7bae40f2-edf5-40e8-9942-bd429e7d0f9f@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <7bae40f2-edf5-40e8-9942-bd429e7d0f9f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfXxfpZjPhuCv22
 1tTFDDI2l0TjqDEbtty2/snXtvoApmDTDscz6QhMUGgw5UJSDPXNfSnLMle39vo7k4SkH3ONIxr
 h3Wmh3pWa0+aA7vgj2tI6ycLMs8xNshnf62ZAn5aG7D8tC9B5zqzZXrnpcVMWo5wW68cey7aRay
 6N0ZDRRF7WXOH9IiMCYN8GMb9CqJ8SJIruRfZydXrd6+LPSbvbdq7TxL7XYYfkml4/rxjdnNhAY
 fpo/cPrUdwgRKJDZlW+XtxJw453uOOOtPCgABDS1Zl8WZyRJF7UbrEZ9nYwQQtropB/ZcoNJi0R
 Za4pzkXkfxNH5hPpd/xho/bR0V3z9c52JcBgj9AjPyP24WMYYgvsrFuufSfoujRiy+EEORG2G2z
 Rsum2/SXs+wGe1N4wbEusSG+m9K0Nk+id2FB5Z6lfOSbf6AonaqTewG7jLbdgL6SDW0iQP6QJ4Q
 tq3DW5U/FEto3dwR6hw==
X-Proofpoint-GUID: eDt_KIhLF4Yvmcadd2EjJbHzj2YkzOy7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfX29Tq1PeTJj4t
 aDqr0joETcgtwmB5n6yV1xV/vTvk994tz7rYmDBTwMfaiIXTVLWWIVfjK2Rwh0Oa62j4KPPqKzU
 1C5rFjX3lFC+QSuvGe7WBissUS9Jmi4=
X-Authority-Analysis: v=2.4 cv=LuQHWXdc c=1 sm=1 tr=0 ts=6afcda6b cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=QATn8TtsVo5dDOwUNxIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: eDt_KIhLF4Yvmcadd2EjJbHzj2YkzOy7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170091
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17/11/26 20:20, Richard Henderson wrote:
> On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
>>       /* compact branch */
>>       case OPC_BGEC:
>>       case OPC_BLTC:
>> -        gen_load_gpr(t0, rs);
>> -        gen_load_gpr(t1, rt);
>> -        bcond_compute = 1;
>> -        ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
>> -        break;
> 
> I don't understand why you're discarding bcond_compute?

Restoring context:

diff --git a/target/mips/tcg/nanomips_translate.c.inc 
b/target/mips/tcg/nanomips_translate.c.inc
index 25d57e75a0b0..524972b24a98 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -2419,18 +2419,8 @@ static void 
gen_compute_compact_branch_nm(DisasContext *ctx, uint32_t opc,
      /* compact branch */
      case OPC_BGEC:
      case OPC_BLTC:
-        gen_load_gpr(t0, rs);
-        gen_load_gpr(t1, rt);
-        bcond_compute = 1;
-        ctx->btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
-        break;

          // now fall thru ...

      case OPC_BGEUC:
      case OPC_BLTUC:
-        if (rs == 0 || rs == rt) {
-            /* OPC_BLEZALC, OPC_BGEZALC */
-            /* OPC_BGTZALC, OPC_BLTZALC */
-            tcg_gen_movi_tl(cpu_gpr[31], ctx->base.pc_next + 4);
-        }

          // ... here

          gen_load_gpr(t0, rs);
          gen_load_gpr(t1, rt);
          bcond_compute = 1;

I'll amend to description for clarity:

   The deleted BGEC/BLTC lines are duplicated verbatim by the BGEUC/BLTUC
   block they now fall through into, so bcond_compute/btarget handling is
   unchanged.

