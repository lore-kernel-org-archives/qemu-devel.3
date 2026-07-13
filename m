Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C66C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 21:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjOal-0008H5-PI; Mon, 13 Jul 2026 17:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOak-0008Gi-3w
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 17:53:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wjOai-0004g6-HS
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 17:53:33 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9Aun2519331
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 21:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rYBDwLfJqBYKA+Gnb1fVSnz3ExCnk/QtxA89M7a1yxQ=; b=fvWe3QC1T/eSmEc8
 s7iymd2ZoDKgVG5tYGy7jMFn7FQFMKn5d5AMRrtK7rEOe8TmNRYvRI3XOv9Z8egB
 GpWogLZwmqB0+qax124ZUpsog+4HTiy2lWzWiLcXWl5QZEx7tIlfN+BAoPJ2PmEv
 SgxkuB7HlTpD3vzc7z1R8SOZ025Z+dn6hGB+RSshU4wZLUkvPcxYwgzCMfYeN/EE
 wbtTthc+7UTRTjpRo2rJDATDifrpAROkkJ481Az69o4QIEdRlQuCCPdtt1sfxI/x
 /gT1TzN2Y2xTgUfOd1szFYizQHwaSa1QBv0snSvbS0Ub+0WYNJ1BKCtaKb4pF0TT
 d+afhw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44crw9f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 21:53:30 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8895156101so2729039a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 14:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783979610; x=1784584410; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rYBDwLfJqBYKA+Gnb1fVSnz3ExCnk/QtxA89M7a1yxQ=;
 b=fa44v+fhQ19wqCUxmPgWhfDA23fmyi4Ly/kOsdUrdLzvzYxQGCYQri4bgdhllcd42t
 Xq738xLoe8aieUW8YTAYsTYH5Kcd+B8NVmNazYN7VsNivkHpW/nOc8J89EbWPS0ZrXhp
 n/OpIdMAtcyxImOnaSXv8Uv9OpQS6IRSJ6QrEfFUX3TihsEk4IGmJIHKxOoD7Ki8krHI
 D1mewWXeFoOT1aihp8RfgxAwWXAU5WaoyvZ45qza/TGm31HgwWo6gBMgIl9cLI967Qtg
 Wudi77kIJsPSRkhCznBGotKyUMdXclozFdAzsrVnWWcitSNIeTolGyOrKkLuL1iqu5so
 yTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783979610; x=1784584410;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rYBDwLfJqBYKA+Gnb1fVSnz3ExCnk/QtxA89M7a1yxQ=;
 b=Om0vzHIjyv4wKQUMb+sIGWuJJl0Ei0ezmLfCV06brM3w2JKpKGrs0HWT+cHcu5Un6v
 xEqtp8o88evGhNX2+XWYBoEBmNXPL73rLcZ92jQRc93Y86d0BicbJI5M+yauQXKCdMan
 Y3KGwIAdqRQBDzpyy5zsnDj2w11kf5zzp031pquXeD3IfdI3KyQxwn7QQxVKDraANjfJ
 /hu6ik/RqL+JHOhkNPrc8FuySOIdHVJQHFkRJuNRS6W2hI1MTQV5KFHMZ/cVaVEts4QE
 Gp6O+3ODexyNion/ex9wpvRmVQJG+io3JHWMW/EprSrq/xV1gWWm6mEw5PfQRf6KU6JO
 2LRg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq1rV+bmnCnHdNBwHQGG5G6vV+U4QVU1dTkGwuhzxu5YfuDu+ln220OkCJY1j1UVM3L3HB9KIP2BByo@nongnu.org
X-Gm-Message-State: AOJu0YxoKCR7wF9P5BJoE8pNU6DhXj/XWqhjWTataN4NtaXBoUormZgI
 605hH9f5hkfcpulFJ0rOi6MEPV9Mbwko1JXmr4bnEnV6fg7G69wG0Nm+ppiwNwPW2bFETfjzJY5
 /Iav92EIHLQlzWTcRgO1evi+BGm8sVTqlAxeWhupmBnY7rHbUwM+2NB4tY6gCMA2lXQ==
X-Gm-Gg: AfdE7cmLSWFP8HBXgjshl0XEw5ZP2jTXjfjbswCr0ds3jcMtY7jb9ZgMbyQ+Mc70Hwz
 hgQ/bLczxY9qJmJoDeQgbsz5AgXoTLntCYA2XpTK4pkkjQ7opnvp+QQu9XWqbuZ3u1h7StnQ92y
 LQKyjyQygqs51btLQVNfEcnRWE41wYHNHIk0IuLVGtpxMXUnRZRjzpBFIzVz1H9MRjJcaSFzBuw
 SassszcGyRMbqOKwnOS63X5aYpfhwL24UDh3aQRqNSIOZUMgpdb0iQRJYVgjZ5XchyYAcRE8O+X
 dgupVZsfA3ztjI6z2hbcMoC5QRY7zqwHW+KIM0meHLr4OQPW/2Ct8JmnSNJHFlBhx4PZosevE2i
 wh0bS+xEQbC8mAvwK0/7BGhAiCMAZqwLq3FyCjwT/nwmW/s8S9WEKk4SRPOVHxa4fApr6eUTSaR
 K6kGw=
X-Received: by 2002:a05:6a21:110:b0:3c0:9c19:65b2 with SMTP id
 adf61e73a8af0-3c110a7742fmr11408744637.74.1783979609863; 
 Mon, 13 Jul 2026 14:53:29 -0700 (PDT)
X-Received: by 2002:a05:6a21:110:b0:3c0:9c19:65b2 with SMTP id
 adf61e73a8af0-3c110a7742fmr11408732637.74.1783979609451; 
 Mon, 13 Jul 2026 14:53:29 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c865asm80106761c88.11.2026.07.13.14.53.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 14:53:29 -0700 (PDT)
Message-ID: <00792d31-5ba5-412d-8985-d6bd8d797875@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:53:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] target/hexagon: fix PC advancement for non-COF TB
 terminators
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
 <c0cc9ab4c7df71362178a74d52a813cc01e7ab8f.1783973054.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c0cc9ab4c7df71362178a74d52a813cc01e7ab8f.1783973054.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: BVohwApkYNoa9OXXiXTfNvsM_4GzJzfM
X-Proofpoint-ORIG-GUID: BVohwApkYNoa9OXXiXTfNvsM_4GzJzfM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIyNSBTYWx0ZWRfX5h7sh5PpLRzN
 UUEWHk+hBNpAaPR/mVz7vN4R/dc2PIb0RpZgRfIHWxlbm9VKhsacGuYxrgDq1e78dCwFszDQBbT
 4qo/7TCaIwbPHFbHoUEx+8zho97y4NE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIyNSBTYWx0ZWRfX0KYlLRfNPXP1
 Nf5vUsE1RryEFB8ZCBZc7UgE0xB7SoTsCY+okVFEWntOnRXcNMoS3YtoCH1Wp3QW27JyAQsAnuv
 AOglx8c+yJ+FdsXnaoEyWjNgqNtbaZqiXPrwULogNSy3ZMyI/3G++rUcQM/3Q67TGdTmZoJAy0q
 Foqt2ZLqGqrcqcRuwIoHtSfbbq/cFqlFmt7DRPNnfW/X6EkMMPz6/IzghN7/6+KdI6YhcTODaNT
 c8b3bXB+texOTnjO5jCie1Lh3UgOu0GnO8oQtiOHTo5Miu07/pIVhiVmY4joHd+StUfemomPGbF
 w2xywYCK277fyxkxmlgA8cRLJO6zMIQKtlxKfjo7gDV0iizANLh8Rroh37r3ML8oa/YC4QcBBNG
 npRt9QeRcd3rEqySon8gONo7slNvtAxvuI6XL7tKaARDm5tGhfezDWVqVOBCtBrcxW2ZPH8ydkI
 88+Cbe/2ayXKZZiK1GQ==
X-Authority-Analysis: v=2.4 cv=P84KQCAu c=1 sm=1 tr=0 ts=6a555e5a cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=OzKHKk3CxOFno54alHUA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130225
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> Some packets end a translation block without a change-of-flow. These do
> not update the PC during commit, so gen_end_tb() leaves
> hex_gpr[HEX_REG_PC] pointing at the same packet and the block gets
> re-entered forever. Set PC explicitly to next_PC in that gen_end_tb()
> branch to fix execution of next blocks.
> 
> Note that gen_start_packet() used to have a special case for
> tlblock/k0lock, setting ctx->next_PC to the packet's own address. This
> relies on the tlblock/k0lock helpers to properly advance the PC, which
> is never done (only env->next_PC is updated, but that never reaches
> hex_gpr[HEX_REG_PC]).  Drop the special case so these packets advance to
> the following packet like any other non-COF TB terminator.
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> ---
>  target/hexagon/translate.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

