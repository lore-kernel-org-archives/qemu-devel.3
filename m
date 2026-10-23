Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C02606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cjsEuAGQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CFThOiRf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHg4-0005fb-M7; Fri, 23 Oct 2026 11:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHfz-0005fH-SZ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:59:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHfy-0000T4-Bl
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 11:59:27 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6EWD2675277
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 15:59:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YOX9uRnIDSQ+wmNVuyWQkT+bBY4ZepF7RoUlETlynUc=; b=cjsEuAGQdRumyA43
 OKAnQdzmY2L2hWQul9wcesN2H8I1AH+C8gzUCJmGP9K3BOq7WtPTxj4fbD5EH3rz
 al1ma57/4CKL8t/UlUcUiiqxosB8vOEBgA/WD/CRSLzNoaY8JqaF4IqCcyDra/zM
 WrrR2IjhArcSKLhVMuXerFCCZtp1Lk6Hb/0NilYrj9In/qLWOEa5/3YoEaN4VTRQ
 bioVf8ntUwSN+BJx9aAaAgbK2BapJNvjNZl74ZOO0XA+APns6XqVdqFqFjDg/VTz
 dTy8ftRPiKtOJSdrbQwvH/tIpwxrG7M5HtqbuvQSLUrN5iACRFVKfqLlHyCWKEtl
 ebhxug==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahvuta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 15:59:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f13c143c8so186938985a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 08:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792771163; x=1793375963; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=YOX9uRnIDSQ+wmNVuyWQkT+bBY4ZepF7RoUlETlynUc=;
 b=CFThOiRfB7P759Ka3OWQgDBc+o/gwCnuR9myyN2MS1eh+ohV+CJblRsXZfFetUIGTR
 zegmwjoOnTFkuSWZcS123xXnfFhtVogg3iT4KIwGL7JuWjGXlad6AXl6NuD9nC0qdF8p
 cmPWudnREl/zDotqBjI4LoXNLY3eSh134VPg7ZrjSR9PstAoG92HH4qN4W2yFBRMsOXu
 gSP3X0dyNwbZrvAC12qea7BMBrO9nCJgzMoTnwRf7VPHCIs0QACiWmFFgXzgxTwyCpfN
 C7CMFqa6f+sdaQCo5E6L2nYlIns09uzJI7UExBYnUGSWOxrncTm4kzD9q0ULadCP8Aya
 sJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792771163; x=1793375963;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YOX9uRnIDSQ+wmNVuyWQkT+bBY4ZepF7RoUlETlynUc=;
 b=RmD32+no33JnevNf08CxiSg/Vsvmh89KZAMpjH/CbTISVglfeZ5YQbFMHDBUtV7XDN
 Ejeoqt8F1hDe7X4pYes5XDPD939wtErB/erEfCioE0WgOv+3GNDjgJZOUGvVtCIcI/hY
 XYoRc4glm09Pq5ZJwbo/nxzmF7x7bXYNUcZY71GnHkpz/y7kOseZWJDsQOt/l8grSZEf
 8yUiq+KfBrh87/zb0BEfmJC99/gT+wAKbH8ebQNaCDdl6V6PzKl33qCafGDBG72GFT/i
 bhhx4Tmkm48LWl+3qDWuGP9TM/5G5FjTr/6DM5QdcJoU9/ye3wVFT+Vuq7C+bHiGxGEz
 Ve5A==
X-Forwarded-Encrypted: i=1;
 AKwUvBx85JgN6mdPorfHJUZz4dsHIGbnWT+jaPO5epzns5/o6muRkmfMCk4gN24AokZ3cpunHeuYtE+V3YF3@nongnu.org
X-Gm-Message-State: AFq9FYJLuHKC4LtcUPiVJ4kwxywPHVe9ngtSunCYkQifieBcQqRhrIjI
 fDio8gagBn8KUwsnhMr8M9otqWH07pB31EIKaHZBrNtd3S5yKNZPDkbf2zt9CZN1NZTLhgalfb/
 UyH41zjxfDisACmnkk/zQ9N+yqukTC3crheSvWRhCvRWCnQOy2n+tyHejWQ==
X-Gm-Gg: AYBFou2E1k6gd/b6aFwf2AbO1gQnlQyYVB2bgTOnPW6VjhdENMdlqSOwNaRhniAOLVr
 075zGxK8TESasvTxrn1rBc+QQP8xG8mhzu28xEnnJKf1+Vr2gQLnP/hMgzUW9Py6sJckb7fU5DU
 YinuRQnHxVc4m5boi5VT/zpdNOc2D7mBO7ZWPFaSn2Kj5JEoXerICoHoxy0pu6vAgL/4WHCVQpU
 sM/XQ/yOijbVMpPB5XGAkOQuNUcfq8x1xZWgULREciIrYk9BVJakRoE74ZwWr7TKUAcp1MPLcvS
 zlcHl94jl9RVBwy1+YzK3BsuRX48IdtNUlfepdKnhTWcw3ufFVX3UIZnNPUYGNo8bBQ6SWgsGV7
 Bl+BsJp51wlkfnjWi9TL3wbmsQIf1WYY8dA==
X-Received: by 2002:a05:620a:170d:b0:93f:38c7:70f4 with SMTP id
 af79cd13be357-93f6f7dc4c9mr442800485a.26.1792771163058; 
 Fri, 23 Oct 2026 08:59:23 -0700 (PDT)
X-Received: by 2002:a05:620a:170d:b0:93f:38c7:70f4 with SMTP id
 af79cd13be357-93f6f7dc4c9mr442798485a.26.1792771162675; 
 Fri, 23 Oct 2026 08:59:22 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29cdc74b7sm22553335e9.14.2026.10.23.08.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 08:59:21 -0700 (PDT)
Message-ID: <3cd34f4a-ee45-428e-a4e0-55ed6aadce37@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:59:16 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/checkpatch.pl: Don't complain about spaces before
 Fixes tags
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu@processmission.com>,
 Stefano Garzarella <sgarzare@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20261023152357.1614817-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261023152357.1614817-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX7v1OvQryGCL4
 dUHtd5bn7TBSKHLbuFoz8RptfaSp3yTpx+6XArBi7vJ9aJUR9hnH2dlp9omPJ0xHRazQ9LRIMfu
 wdAFDMuJS8qQVq4UliJROhd4OpHNSuI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MiBTYWx0ZWRfX15cWSXH9XjnW
 O2Ftn64qrAOpzHeUNT0W/b6qT1rYJpSGiUcMnKsM2hso74d9LltLqvF3a5pINzjXOlaGQefAyr0
 +G+WNlsMjRMiT4RyHkAG6VpWfWlkJU3H6lFw8jQ37in0TDw0VbA494/wjUn/V2S/X0Gce62cCD5
 yUgflXd8pvw9ZyAksnZNFCbZ7mIPwukXR9AmvQlz7d2SGELo6gB9nCPlyeRlvfV+75eJ7ZtAfnt
 krSbrPPb+pbIufhgaPxn21kO+41MfGPRE7jFWPj+J6lz0cXS7vaqxun/2hXToMFDfZo+xQk7Klm
 DHyYKGBH7SZ6bDczZOIwqHagc3tZ2wl1FK8zu1r1JKWHmhsFgbKT6OeEjw7v+Cd7vUU4/MDHvqc
 TwVbcxrbsa2fmE7AH1oEmf9t05mdSGwPxGsbgWaSShPbTzOt1zeShqmqouTwa6UpcqMOwW/YVJg
 vNLbD6QBV2Ppv+QldAg==
X-Proofpoint-GUID: jRQ2wuPIGhDPXuX5_W17wxJD8mSicPKI
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adb845b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=a9nuIxzwBfW6VTgx0rsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: jRQ2wuPIGhDPXuX5_W17wxJD8mSicPKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230062
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/10/26 17:23, Peter Maydell wrote:
> The checkpatch.pl script insists that Fixes tags are at the start of
> each line of its input. Although this is where they ought to be
> in the commit message, it is not where the script will see them
> in common usage patterns like
> 
>    git show <hash> | ./scripts/checkpatch.pl -
> 
> because 'git show' prefaces each line of the commit message body with
> four spaces.  Allow spaces before the Fixes tag; this matches how we
> check for e.g.  Signed-off-by: tags.
> 
> Reported-by: Stefano Garzarella <sgarzare@redhat.com>
> Fixes: 910e1d41be6b2 ("scripts/checkpatch: validate Fixes: tag format and commit ancestry")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I just ran into this myself today as well so wrote up the patch
> ---
>   scripts/checkpatch.pl | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 5df266acb17..82f62f60212 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1889,7 +1889,7 @@ sub process {
>   
>   			if ($line !~ /^\s*Fixes:\s+CVE/i) {
>   				my $tag_case = not ($tag eq "Fixes:");
> -				my $tag_space = not ($line =~ /^fixes:? [0-9a-f]{5,40}/i);
> +				my $tag_space = not ($line =~ /^\s*fixes:? [0-9a-f]{5,40}/i);
>   				my $id_length = not ($orig_commit =~ /^[0-9a-f]{12,40}$/);
>   				my $id_case = not ($orig_commit !~ /[A-F]/);
>   

ERROR: line over 90 characters
#36: FILE: scripts/checkpatch.pl:1882:
+				my $tag_space = not ($line =~ /^\s*fixes:? [0-9a-f]{5,40}/i);
WARNING: Please use correct Fixes: style 'Fixes: <12+ chars of sha1> 
("<title line>")' - ie: 'Fixes: 471d4930470a ("target-alpha: Set 
fpcr_exc_status even for disabled exceptions")'
#24:
     Fixes: 471d493047 ("target-alpha: Set fpcr_exc_status even for 
disabled exceptions")

$ git log -1 --format='Fixes: %h (\"%s\")%nCc: %aE' 471d493047
Fixes: 471d4930470 (\"target-alpha: Set fpcr_exc_status even for 
disabled exceptions\")

Cédric, what is the format we have to use? (why mine default to 11
chars and yours to 12?)

At least that removed one warning on my side, so:
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

