Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1935DC5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwUV5-00073C-Dn; Tue, 18 Aug 2026 20:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwUV3-00072q-IW
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:49:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwUV2-0003Xv-0A
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:49:49 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INkVJT3834615
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OSNvWQnGP4vdifu1Zgm05xX36ztGnaHqMdxoxHB2sTk=; b=eV8cYyfBQm5Vk3WB
 gv3C7LYgvY6RSKWM9uOnOPdNXgrB33h64nYO+200zHsdZai8hNIIHvqVSyoxtZsT
 Cx3x6GBuaBLkPxMU8J8QESr5eHae88VmtM5hykkFwG5xE+C4YT9Qc3g3RBNh7IYV
 CShBnRyLdO+oYB57I0GNsy2WAfVFX2lMv4sHwgyurVEZYKuuUUksdykzYm7bf+F4
 gjxeDoNK39IQ+LNrhSx51EIjo73X/UyqDfUuuqKsuofWr8RC4OOKWcd8exZbfi25
 n/4nQtj13a1uYUUwKVzeYJZ4pa6NRceSV05uIsnc8EHW1W4k1VYXO5ZAZXqkB3lC
 TCsu7A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm0kf8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:49:46 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934963b2bc0so54881785a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 17:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787100585; x=1787705385; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OSNvWQnGP4vdifu1Zgm05xX36ztGnaHqMdxoxHB2sTk=;
 b=OQ+hjWa1sia+uWmTekdi7c8lCX7sfF4i4pNOYXiva0kxVCWOu1dQ49CYs5oXVNIRON
 V/8nlvBZVG715XpCXYolXPfdNmGA+UdqoZBsA8/KIyOuBjGsD+cUz96IpmWg3vkzy1HX
 g79E2J6I7a7A3vtq9pR7UKCS1mDPua8G5xjzuU87tOVaTRj79mRmhpDp5t/BfeC6JemP
 Lp9fwz4dvKViHquGTLWMh0pMsoBn6dEm+dntlEIzKrY2IIzj1hZ/xqY2jdcRE7wXfDTS
 CCMdlGrkWUd8mJ6FGL76xPW6/EmqT2R5PpZdqtXKltpOAAqZlGrxIifiEi4dQWk6NVCG
 WNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787100585; x=1787705385;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OSNvWQnGP4vdifu1Zgm05xX36ztGnaHqMdxoxHB2sTk=;
 b=pJamcK7R1gS4U0enJdqRBkgz6ClpZQBaGbYjO2dIY5fOWcmEVywzK4H1c2MiZtEu+1
 jB+kpnIe2obMonG33Ac6dhXI6yEkViX9lxiQ0dITGt4LiI0OOTlJUrpIr3tYXL9m8sA5
 XVgy9JYRL+PdDMWO9TJ0bqGvuRtYCZwpOkvUJTSsy8N+YE6LwxOgA3bI4qUNR2nYwSCe
 zAzz0aPe8eZeC0Wgrrf+j2GFUZ4Soa+5TOj3mOO8xkQI1A8qzDN9ks2WsXEc9A95Ilv4
 bCUdnfjkRXnJUoGeAxQd9pIdUZkWyy5MmMlhHBcM21e1E5AcKnnlZGK6jUZjg8j8clJp
 z4rA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAR4PUwNvBuavSFSm2bOpdQaRN+X6O1bBN+nrkYfHh1mLGU9fUgqZcaHnmVymJ+aVV5a905dsoneln@nongnu.org
X-Gm-Message-State: AOJu0YyKGFcxfKxekFCcJDFawLl+MbfEgq8C0KOXib9whw+PzXMDZw+0
 Xpg2WG5BEX4J/PrIYcHbnUNAeBj/30YkBaKf7ldLIWJ8Ik9zgorHh/6yJQhSRyoGpak+O2GEaur
 FVqyLIiFHIrhCf/55ldJGSBdkjxjav3mG2pJ3oYC5PUieaxTFAFT+q5b0cw==
X-Gm-Gg: AR+sD11U3Q2YpeXfFPRK1tn1z5vGcVm3341FKyi2dlBkLgg3F+dkhkr1HPahf9tBaqW
 lKw63CFX+nghxKF3P7wYtrpfyX6Daij6WA5jPgkRim8bythVtveENR4t9427Te4b+wdDyFjGomD
 45e/Czevsh/m8riZHW4NRXUl2+WjPTXIrMOyS/kyl/HbNhf/9D/dzW1X4GVJPDsrc7ySabuKMO+
 cyv9RezZ6iyQaj4dpDgpOebaSSY3+gP1T0YxkIXtuJNg4xZ3I+HMOY9YTwSAuKwV7iKGqzkMmwq
 43k/rWa8ZAQCaf/0CQlQ/C5R7HQ5fA45GStMTsUseM9tAgFEbHu+Uo3/5zw6TYlA+jVqk+sM05U
 scemx2cW1jJVqPDYAIdOIesVmRT8Dm0zQSaY=
X-Received: by 2002:a05:620a:2586:b0:92e:7733:e3ac with SMTP id
 af79cd13be357-9371e24d69fmr122742085a.20.1787100585015; 
 Tue, 18 Aug 2026 17:49:45 -0700 (PDT)
X-Received: by 2002:a05:620a:2586:b0:92e:7733:e3ac with SMTP id
 af79cd13be357-9371e24d69fmr122739285a.20.1787100584522; 
 Tue, 18 Aug 2026 17:49:44 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b145153fsm1338767f8f.12.2026.08.18.17.49.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 17:49:43 -0700 (PDT)
Message-ID: <b1cb5c81-cd9b-464b-837d-df8a2bdc6cef@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 02:49:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] hw/vexpress.c: Remove forced cast to u64
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
 <20260818172012.3052821-3-peterx@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260818172012.3052821-3-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAwMyBTYWx0ZWRfX/vNMerrE/V5o
 jyNBVjFelRFI2otIkCidPxqz8TUHN9ZCFftQkVm6NwROPjObg8OpzYwZFsUA87E+vW3YLDojS92
 h/cOQMAbkDDV03Khr1StE/SM7x3ienU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAwMyBTYWx0ZWRfX8wT7kjVfgL1w
 O5f1205F2yAawxqsZXYrhME5NYRiWMpgFPv5oE8XJ2tMh7bOS5V6CS1Fh3QNfINbT4fkaqf/chD
 kktI0GgcchaSmeiaL8Vtygfe0WopJW1u6Brhid5+CRympyhWh3RygAuKn7sJT/60hWnceSkCiHG
 npVC0VRl4QIbAucZXsiReP8K8f4L2K+dcGJpShqWa+iZgDPZ6kCiJuRMVNFMCoUuZkD6+/CvAwx
 hym8UMlZ/xYjGGa7wr4vjQFeYXXL4km0MbHGsfPNnpqnKdXRxYuLNx+P5TlXOQUT88smmg5V7DU
 1grAMf6TpfOzhGMNYaJqjML45WHaZ93X9QYKTgrLFWFJ6xoBajci4d1f2xnfPSGKbrKKE19NTcQ
 q7lLV9/VsCSws14AQ9oH5n5d/8Y1iF+PUQkmDocRqJryCUad9sBe+1Swuqah5+ZT8gdNCcPc7o7
 tnwnXROYWiLPXP0ah/w==
X-Proofpoint-ORIG-GUID: CoKj8iPQHjXPWm7WZF-tf29-DdhRNszo
X-Authority-Analysis: v=2.4 cv=bN0m5v+Z c=1 sm=1 tr=0 ts=6a84fdaa cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Nci63-FIB90mRSizHUoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: CoKj8iPQHjXPWm7WZF-tf29-DdhRNszo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190003
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 18/8/26 19:20, Peter Xu wrote:
> Now since ram_addr_t has switched to u64, remove the forced cast as not
> needed.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   hw/arm/vexpress.c | 13 +++----------
>   1 file changed, 3 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index f26d8c6f8d..a6ce426356 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -363,16 +363,9 @@ static void a15_daughterboard_init(VexpressMachineState *vms,
>       MachineState *machine = MACHINE(vms);
>       MemoryRegion *sysmem = get_system_memory();
>   
> -    {
> -        /* We have to use a separate 64 bit variable here to avoid the gcc
> -         * "comparison is always false due to limited range of data type"
> -         * warning if we are on a host where ram_addr_t is 32 bits.
> -         */
> -        uint64_t rsz = ram_size;
> -        if (rsz > (30ULL * 1024 * 1024 * 1024)) {
> -            error_report("vexpress-a15: cannot model more than 30GB RAM");
> -            exit(1);
> -        }
> +    if (ram_size > (30ULL * 1024 * 1024 * 1024)) {

Note we have a more readable GiB definition in "qemu/units.h":

   #define GiB     (INT64_C(1) << 30)

Regardless:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +        error_report("vexpress-a15: cannot model more than 30GB RAM");
> +        exit(1);
>       }


