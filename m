Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC9AC44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk1dy-00023I-Mb; Wed, 15 Jul 2026 11:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk1dw-00020e-PK
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:35:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk1dv-0002gI-4E
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 11:35:28 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FE3OCT3957701
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 15:35:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oKEB1Wrf8QZ/8qZnB/Ugfln+7EFgQZLto9Ix7VF2P+8=; b=MVAF0BxWgNvhfOsU
 dIcEOeTDIFRPCAIGuyD8afUbVX/h4v2CyU2CXMl9EfbZHQTAci94lQ2Fea5nbuMl
 3uLI2R5wlt2oIFO+79lvLxwY4HyCPS9H6Mxogz2OMSbuPG/c2Om8tvI0fV1k7sTF
 VBs8cajv30hkHdIgxPPBE76zHz6Vnhy34DDIugqEfR7W4XJPl0fzoAuc0AmO0SFs
 fvUvddzl3uCZ/3+ad0qzCS4MPWHEeKWMTnghgv4CPj7p2/bptBwUg86/eZwZj4nn
 a/lrwy56ZXiYGfWLW9ETV4d4ec8Fbai6qoKbPMlmx1cEYYumL8hj6nCbaBpP5g9F
 YrhFOA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feayfgmjm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 15:35:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca860baea9fso5375593a12.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 08:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784129723; x=1784734523; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oKEB1Wrf8QZ/8qZnB/Ugfln+7EFgQZLto9Ix7VF2P+8=;
 b=IDcEgUHEn9zmz3xE0UDV9yHzDunknC9MVIGWmEgUiPzVstfeR6vCDrBNw5vNKJuKrS
 K/KHJbxAgyWYmzunssLApW8odlE71hhIRWPuoOrgF4RERdA5RJPphBp5DxFiTGHkID1Z
 XJ/YlZpCXmS18v9MGdi6/r/Mfe0+csFbtErtDEKF4qxAXid9+kV84qv5Te69K9bpMxKz
 P8RoerVok93jh1XZ4rH4EKdtTY/dIs1W0l4WHFV1RIusnc/K8ThWyi6UhmpJNEdAijA2
 t4FMlPRLv/kIpTrxmxgA3Y04C7uTVWjI96HEAkaL7otPgLJCTcCrJ0Wpu82Dg/i0Pant
 NsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784129723; x=1784734523;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oKEB1Wrf8QZ/8qZnB/Ugfln+7EFgQZLto9Ix7VF2P+8=;
 b=esAb6+m0BiWwHpmR0g2+jsnKjVOnqP6FwCWoI87BEmYsHTudJ3ZPOIzGQ6TDqE9l2E
 yMn2KKHIVWK68fHh2jJwgSfQgyfY3Ly70mrZEv4I9cxJLb7DSdUF3P2+oZNIRrKpVXHl
 48O35wtSBQPbNRUif9y+axFwKoNrz9P7S4EBIUIgYGnmXt8XIO9vMOcwkxAk5a9n4ge/
 92ADwKemaECvF63XwgPTIVAtbrZs4RlEEYzm7JELuD/24A6bWwLAl9OPlNesRjekRGua
 oHGja6cGVAY5c98XBCd5/JCTBc/1qpStP11B6ht4exc+4i8aiTva2kXcu2llPZ0fn3M4
 t7Tg==
X-Gm-Message-State: AOJu0Yx3KRainXR2Kwavfj1dIokwispozcnJ3A3DR606CB2cVy6doXQg
 uFIrzud+1DmvseBQpBjRZeBLXK450d9fft1dlvzt0tqlRnTYM6R0vzTvrWp7ZZkBtO/wF9zm4/9
 BWL+r555+ixU6vpFFh7wCuwWSWvjPfEaNk13SUO+fW9srP9cDnSqC8MG+jA==
X-Gm-Gg: AfdE7cmBY06nwTL4K3M9ovDYhDZzhAO1tli/SWVmhUdWEkdnGOv7FHa61RTq8r70eSX
 HDQUjkgbNLhLakvupRftiUu0j/4G2pJxH/L3XnfyZ+i5DAhWyS1Fb71DbS5UY4PKZ8Ka7h44adU
 x97ePuAoD8+acOYVCRen1GJMDIx6FnNKmxUdbVLUkhKBcIAZhPkh9lhOuC+mu/24xK/uqffOeZV
 kZNDtr9LXtcxq/sTudUNH43N3z9zeWBL7vupTcf5Yl6qYjSWTEroYGNMgFsgx49VV/bJMBwG0b/
 IeJCOdqZe5vcnuebSA7OVQcIbG29ioTuwVO5Wv4yLnioJy7yB0dyLqbWiVDfAaopu4gOAsVvWv5
 afJCmmdThi9Yr9yUvEwT2UQTb+a0Ba2SaBQuTb3j9ikwnGJLzzyK5dWDg2B7VPdIY7WE5vbYqwy
 7hIsc=
X-Received: by 2002:a05:6a21:6b17:b0:3b3:241f:66c4 with SMTP id
 adf61e73a8af0-3c11018d946mr19796923637.28.1784129723202; 
 Wed, 15 Jul 2026 08:35:23 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b17:b0:3b3:241f:66c4 with SMTP id
 adf61e73a8af0-3c11018d946mr19796886637.28.1784129722622; 
 Wed, 15 Jul 2026 08:35:22 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13cd426ad8csm2277953c88.3.2026.07.15.08.35.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 08:35:21 -0700 (PDT)
Message-ID: <3c7ca00e-a78f-46fc-bf29-bee2cb3fdef4@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 08:35:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] uftrace: riscv privilege level
To: Yanfeng Liu <yfliu2008@qq.com>, qemu-riscv@nongnu.org
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, erdnaxe@crans.org
References: <tencent_E17E8F6494EE130F71527C6BCE481AF33E08@qq.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <tencent_E17E8F6494EE130F71527C6BCE481AF33E08@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zy5YFNPNQdEPzO9oSlp-ufHCKlweAE4v
X-Authority-Analysis: v=2.4 cv=WoMb99fv c=1 sm=1 tr=0 ts=6a57a8bc cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=dZbOZ2KzAAAA:8 a=2EAK0dWcFSsNEvSIV9MA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE1NSBTYWx0ZWRfX74MLtTPinxNa
 L1aoeh9Xu7W3UVWt+gRlc5j0c+RtHBGQNdatLnIiiVXSSlrTOlJlW5bDCc7Y1jEij5yGy8GRICp
 LdsuER5EQDGHXdDWRWUIKywAkuRSOMr/Qv4IuwPdznPeCiI+rkYT9P6jmvtds6ps+384ZeX8x/S
 TmjeKluo1mUCC4c+pSlY18+VklSM0GbmLD7f1zQOrsFGpNNBzQxr5VY25TDw6D2rijriC9JsMyZ
 vd19RcThkI+kvNI69MtAgcameim1gPWJJpQY3TboHitu57eMH/7BnNAnwcnyTV+eUBpBujLvNmn
 DTkYFMWYju97QbkX6iSYHHl4U4u0xhCOkOpDLQ4DuSWqWxa1n0JT/b7ct3m3Z5MyMuNjygI/YvM
 SpaY/dUnO/R436/uOfSVKw76vW6sn9k2p67mh7gm2DvZE8oVij3lYkXC+wbb2Lc/nQI6t+O5QuN
 sM8AqdWwg+s5j1Txp0A==
X-Proofpoint-ORIG-GUID: zy5YFNPNQdEPzO9oSlp-ufHCKlweAE4v
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE1NSBTYWx0ZWRfX/N/wk3wqNCb/
 EhZ/nA6x3C+Mbv3IhcfRw4u7oCOZKgd90n1Z2vyGDQnztrSVi9V0DPmX+TTuy9MlqOTUuW6tj+W
 A6WHuLMa6ocGc2JUWgc2MMTkoJX5IVA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150155
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/12/2026 1:45 AM, Yanfeng Liu wrote:
> This adds RiscV virtual user and supervisor privilege levels to
> uftrace plugin to avoid crashing with H extension guests.
> 
> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> ---
>  contrib/plugins/uftrace.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
> index 9b0a4963ae..063e32220b 100644
> --- a/contrib/plugins/uftrace.c
> +++ b/contrib/plugins/uftrace.c
> @@ -109,6 +109,8 @@ typedef enum {
>      RISCV64_SUPERVISOR,
>      RISCV64_RESERVED,
>      RISCV64_MACHINE,
> +    RISCV64_VUSER,
> +    RISCV64_VSUPERVISOR,
>      RISCV64_PRIVILEGE_LEVEL_MAX,
>  } Riscv64PrivilegeLevel;
>  
> @@ -153,8 +155,10 @@ static void uftrace_write_map(bool system_emulation)
>      const char *path = "./uftrace.data/sid-0.map";
>  
>      if (system_emulation && access(path, F_OK) == 0) {
> -        /* do not erase existing map in system emulation, as a custom one might
> -         * already have been generated by uftrace_symbols.py */
> +        /*
> +         * do not erase existing map in system emulation, as a custom one might
> +         * already have been generated by uftrace_symbols.py
> +         */
>          return;
>      }
>  
> @@ -706,6 +710,8 @@ static const char *riscv64_get_privilege_level_name(uint8_t pl)
>      case RISCV64_SUPERVISOR: return "Supervisor";
>      case RISCV64_RESERVED: return "Unknown";
>      case RISCV64_MACHINE: return "Machine";
> +    case RISCV64_VUSER: return "VUser";
> +    case RISCV64_VSUPERVISOR: return "VSupervisor";
>      default:
>          g_assert_not_reached();
>      }
> @@ -986,7 +992,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>  
>      score = qemu_plugin_scoreboard_new(sizeof(Cpu));
>      qemu_plugin_register_vcpu_init_cb(id, vcpu_init, NULL);
> -    qemu_plugin_register_atexit_cb(id, at_exit, (void *) info->system_emulation);
> +    qemu_plugin_register_atexit_cb(id, at_exit,
> +                                   (void *) info->system_emulation);
>      qemu_plugin_register_vcpu_tb_trans_cb(id, vcpu_tb_trans, NULL);
>  
>      return 0;

This was merged into master (c149f7b367fe85edd1c438ecfd876f0c80a6ab11).
Thank you for your contribution!

Regards,
Pierrick

