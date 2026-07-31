Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F43EC5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 17:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wprFL-0004aB-3I; Fri, 31 Jul 2026 13:42:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wprFJ-0004Zv-A8
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:42:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wprFH-0007E7-Mj
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 13:42:09 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66VFOluM3880586
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:42:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lsu8mcj8OGaMbC+fv6/VmPzQ2c6wYXYEEqMcqUuJu4Q=; b=NF8mMK5HXjUeETu6
 JGF0enlEPZpKX8gjQgGyNiBgr7aPoQ/2Rs0Cdn/egbd+SojDsurNDxHAHq/noT3U
 veacfx6A52enx9NZ4R2gpuIt43ED82cDWEOiqCt3i/RZlUXMvprL0n4UVXysNcAv
 VAKp+Nln6eRMZ3blGun6qe1crOrAbBhatwwrP+RXaxJrVMTfmXR/aisoRYSlRKNb
 stbPnRSecjjU0kBqwhfDyRtPEznMAGQD8Muqbv7sNRN4IhItzhLl8XuCivkHATn+
 cmMet7nzs75qS3u3MWu4piMBR/6H9eGmeuWJdvHAU2SwRI6y4JHpnv3WZnbi+o6B
 RpDBnA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru0y1m1w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 17:42:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d04908139bso12636435ad.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 10:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785519724; x=1786124524; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lsu8mcj8OGaMbC+fv6/VmPzQ2c6wYXYEEqMcqUuJu4Q=;
 b=Eo9b4BuHg4FwMNCOx12uAZDn25Fc0BcSZfwYRomxErOoRZWtGpDEdiDaArkicdrIVZ
 9w0+KPK3lHFqtNlE3ZG8MmpJiPSc5TE8qIiq9qEFJryHBRcBczmxDShhevp3WHSzdq6L
 4R9QneAjZQwICEu7y6W4oMYvccgwlFTJDAxJoGykRDoBMJtdrDsc7csYbDlSw9uEMkv3
 X3JlEGxE7YtVWggz43lfLgr19RC++e2uc4y9C3Y6bdFWy3asEUgtu6RMHeOdP9pKXJgo
 r+BqOtO0hGR7xFNW3AE0Q83D3SEi2kQDmO2qDxGkFdBOkxNd3M6b09H+Ccpdah4/Pdza
 1AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785519724; x=1786124524;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lsu8mcj8OGaMbC+fv6/VmPzQ2c6wYXYEEqMcqUuJu4Q=;
 b=bso65QzRJbiO+UXR4D5deIvilHZsxWfDefXChSpwG0ZzF5XGftoewGWKBu/vLODT1G
 qd9i1wNQwi/Ve24oBBrKulcwBz+0Y6nOOpO4SCQWpMAlwMQig/afstDGofnFuUpvoXSj
 YecfSnkndlVZvKcL8Oke969BfxmUnFdSFktQVaxGg8wT8hVl/RdYM8YVwQo6e+TxM1uQ
 07hxtxz7DOdZ4sbz5MjeSl4GWvUFF34/bPlCpOS8YHoLTvWCo8EQFw8yFeeP5f90IBjo
 ovhrkVsX41tZEX61R3mdTENFVjagOn+uxccd4G12DyCysvv31qxlJrZ4UCScFIth2YA1
 2+Rw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoWGVHfpVRa9YudGrhwW2FPWwKdfXvvfXbjmTtuTcjUaot3CRInYeGsIFo08RS1dbO4FldwZSCgszvK@nongnu.org
X-Gm-Message-State: AOJu0YxU3KJkQPGFF0xNYdUGr6y9d9aIrupLpbZ+YY+47CbChi96mu9g
 7OanZpQmPZ1/lz+n3Us/LnDVqBF9QTu/zhUGENiITtCX36jIHWqOpnGKMCIApjT/2+A7cZ0tpDi
 3mE5Uaq4FHdYnZPAsTachRpeogAfarx0KDekUeYGMkgmorDw3eSPt+znTNQ==
X-Gm-Gg: AR+sD11lGjSO10Z4d1wsEGThgbM8Mu7oUBK6XiFArlFHzDbqCxTvx7E5K/vAwrTqzyN
 m4GU36BvUewyo44xFX5Hg2AutTQQ7TEe1nl5JItwsD5eJLz2jzq9T30GHviWxav8CU2VFxKCnhX
 Dus9Zn1qQ0OzyVlpgehT5wL3aRk0R+jzpUG0PwOgtpnnebJizCYp7O5FeCrFd9h0QmAptabSQOw
 nRnBRtcUb6CCFQC8SHHzzLTfzgje2NYzG3BdrItE8858707LJbuNNZb8WSjCtALKoFhuZciIb3z
 EfcfBOubngX9OcWeYitCaXQlsR1PX0LS1Ix+KtcnvKA2JTAlXnkmNI7qWBVreSrYXtxY1mvCMsA
 By+vxWulFo8WIQuea5lwh1kh8DNtFeeazpLN1z1em24rNC913qv59GchtC4o81DGzZzHl
X-Received: by 2002:a17:903:41c9:b0:2cb:14b3:4cfe with SMTP id
 d9443c01a7336-2d0524cd9famr7475515ad.45.1785519724071; 
 Fri, 31 Jul 2026 10:42:04 -0700 (PDT)
X-Received: by 2002:a17:903:41c9:b0:2cb:14b3:4cfe with SMTP id
 d9443c01a7336-2d0524cd9famr7475205ad.45.1785519723584; 
 Fri, 31 Jul 2026 10:42:03 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04ae67d0esm8611835ad.30.2026.07.31.10.42.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 10:42:02 -0700 (PDT)
Message-ID: <0c791fd2-f4d0-4f3e-8ad5-4d61ccd724fe@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 10:42:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/18] tests/functional/hexagon: enable more arch_tests
 cases
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
 <20260730012824.1135905-19-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260730012824.1135905-19-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDEzNSBTYWx0ZWRfX8AagPSbE0YQf
 wUqC8arM1uTwUVk89t1uo+/1ug5VsCjx6BAvDoAjLgvkJ2H2JH6uSZkQuOogjzbcAxOuFxEmPme
 Ubk9BN7S1uqfBnXYHzOPCLwaX728qMg=
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a6cde6d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=z_v1lxIGAMg_LD2hhRMA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDEzNSBTYWx0ZWRfXx4freITnjhPe
 UDAQ33mXxtWgWgh1+PGu82HLKwjXDNJLmH8srOp0hlWr7mC5gwg3w9djFGHm37X+TJ+PZKMZROj
 HZFr0PgHwJBk47T1R7wXwm5JNmY8K/reyRyamgAaV4dGV7n7f2q8pIB7s8o4LNCSp9qcTE1gf/D
 pNTckhkZsSdtNGWkgBRJIhKCQutCPKBB4pG1AsAZsunB5rmGjXJ/nLIvUsNANtOh6Ak0vJx1r6g
 d6r/9uoyM1Gn4uSSNI9T9kRty0v2x5Nh/iEg6jTQVDmlvbrfstj8uckZJSUyd3s00bV8WRE2jr5
 bSkP17/rvcbCIy/fdBVRcXrTuhyMb/2CKjy0e8lUk3uVSIM/3IdYVoiWvZGAtp2+5Og3eOVRyz7
 HgvxiCytfvuHuQrZMv84EZQfh5C1qgJ38zAMApdPBPJzO8fsqqI7+ANqlAZPGkF8O3qDWzJC+BO
 BMIwLIkTIqLWhnV30Kg==
X-Proofpoint-ORIG-GUID: llw7Uij4JLWzp4tSUeozbDrATNFJsWhH
X-Proofpoint-GUID: llw7Uij4JLWzp4tSUeozbDrATNFJsWhH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310135
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

On 7/29/2026 6:28 PM, Brian Cain wrote:
> Add more tests from hexagon-arch-tests, enabled by QTimer device.
> 
> These exercise cache maintenance ops, l2vic, thread start/stop, tlb/mmu
> operations, and user-mode transitions.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/functional/hexagon/test_arch_tests.py | 32 +++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/tests/functional/hexagon/test_arch_tests.py b/tests/functional/hexagon/test_arch_tests.py
> index 2bb34f9b8dc..0834398c3b1 100755
> --- a/tests/functional/hexagon/test_arch_tests.py
> +++ b/tests/functional/hexagon/test_arch_tests.py
> @@ -58,6 +58,38 @@ def test_int_steering(self) -> None:
>          """
>          self.run_uart_test("test_int_steering")
>  
> +    def test_cache(self) -> None:
> +        """Tests cache operations: dckill/ickill, l2kill, dczeroa,
> +        dccleaninva, cache disable/enable, barriers, and dcinva/dccleana.
> +        """
> +        self.run_uart_test("test_cache")
> +
> +    def test_l2vic(self) -> None:
> +        """Tests the L2VIC interrupt controller: enable readback,
> +        interrupt type readback, VID capture, and the fast interface.
> +        """
> +        self.run_uart_test("test_l2vic")
> +
> +    def test_threads(self) -> None:
> +        """Tests hardware thread management: start/stop, MODECTL state,
> +        per-thread HTID, shared memory, wait/resume, STID priority, and
> +        SCHEDCFG/BESTWAIT readback.
> +        """
> +        self.run_uart_test("test_threads")
> +
> +    def test_tlb_mmu(self) -> None:
> +        """Tests TLB/MMU operations: write/read/probe/invalidate,
> +        global entries, multiple entries, overwrite, ASID matching,
> +        and permission checks.
> +        """
> +        self.run_uart_test("test_tlb_mmu")
> +
> +    def test_user_mode(self) -> None:
> +        """Tests user mode / privilege transitions: supervisor mode,
> +        SSR UM/IE/XE/CE/PE bits, and the trap0 user-mode exit handler.
> +        """
> +        self.run_uart_test("test_user_mode")
> +
>  
>  if __name__ == "__main__":
>      QemuSystemTest.main()

A general question on the pattern we have here.

If those tests can be compiled with hexagon-cross container, would it
make sense to add them to tcg/tests/hexagon/system directly in the future?
Hopefully will be more easy once we have meson tcg-tests, so you don't
need to add all dependencies by hand.

Regards,
Pierrick

