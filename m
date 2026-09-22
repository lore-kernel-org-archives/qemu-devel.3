Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D297C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8wMn-00075S-SM; Tue, 22 Sep 2026 05:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8wMl-00075A-Pj
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 05:00:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8wMk-000296-3V
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 05:00:43 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M7C1jv1980018
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Uhg2O7qhe9O36AaqOJA09J7WioVPkLA66QzmU0rHPQ4=; b=d4qG+QSJdasXgkyU
 temmHLRHGd58Ltjpd1O/Gs7Os7YftpKdOLWKb9zXbvCVs1MzNHjv0tQMv1Igjirb
 OapIZIbVAUNhuI6QFDnr/uWVb87q3rlT9/n7sYbNL+6Ddl3xDZjJjH6xwW/NB/ZW
 24kLNHf7Qv51HWEizIHtAYTMoqEKbZHwTcpO1CQvvH22NjRPfm5zplOpTcJNT9on
 C33Gl2kflsM6gRZWXwcqrsV7f1vPUnPaU2ZVQ05JKGc7R8O8DrIZSP+v7WTbLNWu
 8KWj2isSgyGoDitTQJt3lStNMHDE0Q1c1zAd9As1GXnHjmX4Z22kMjSwdQXV6r05
 Nek8eQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gudw0j0e2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 09:00:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9393ac4961fso525279585a.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 02:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790067639; x=1790672439; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uhg2O7qhe9O36AaqOJA09J7WioVPkLA66QzmU0rHPQ4=;
 b=d9CC3OdP3ADybq2gZXUWHMwIu9QARhNo9DQHGVSYCzDN2dVwhn6NTL4hN6k+dhPka8
 EReg0IZ6aR0ofJvX2BW0dMIS+e+qYo27J6ei+0ovS3o1VwKqwUz73E/nN4nRL9Ef+KQa
 6qzR0P85cZ7VfA1Au7HFt4hJJ2FqzBeUavOMGY3zgGEA/xVGPdDupjEm5ov+t2dMxnIr
 NbA84lHfe6d5p8nI29PZ9Zs2XiUYDBaPg24q631CBdnY5cdVdn9iFI/PrMurrRsgC6W8
 slM1ZkdiPH/Neay+d4Z0cMEAWn8eScFEMRBoVMiGIAlRHwzOdUj9Bl+cv7PzfZfvEhKE
 w86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790067639; x=1790672439;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uhg2O7qhe9O36AaqOJA09J7WioVPkLA66QzmU0rHPQ4=;
 b=HsT/SnjXHmc3/lZnahE2Alkt3IJlb1bKRxUNt/Bmojt0/6U34zO37PbCKZlQ8U/0OD
 xmqVkVU2gMF3XHWs0VSS4S8eGdduWKMcxwOAVR9lHzbLVIH9E1KVIxpykfRta04gz8bF
 E4BaZ0krwmuhs7f9Ohw3mVEhnZqNosgp4EpgU6H3Emh0mr4BNWEuz7dwYTFkZR3b5vsj
 zkCJlutEYdQLQ1yNimzq5hrJGQSHFBunZgVaXxIhANOI5t+e3Bvg1Y6b8YWYp8NPXaJY
 o5TAoeVDArYTNUWI26tdj5yGNvVBbvl9aSCH6gZb55rF+XkGWhLK/ZWkXJ3sBYKGr4ha
 usRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZkvHKWoiH6Xlmw1/mZDtULbFOu6ZO95NH6MwMr9kFItSx+ON2/kDmLOGtcrBbwOo3lJ2JNFO81wWD@nongnu.org
X-Gm-Message-State: AFuF++k6aP8d/h6KjiwEHcEaR2hrrU49+oNbz3OxT1NSXB8BUCjKMn+A
 +Tq7i3/tf0tnsi//oXac9zdihuohaZ9vKs40q+Ou6irw0o5Lx2yFrGj15X5tt3gCjgnY2zWU+qM
 8okAnyFMjF4zAsU9gRWJ77M2QRtuJpzz79QkXz7D4JzHZ6VyvK17vnpbXUg==
X-Gm-Gg: AYBFou2A8HGT+X3prxVOaHWHs4VTan/WI6TE2/7FcMECpDQedROBwRMEGHFrFeRN7n8
 PdH+sqzkTXmf/ns8dLQrLZ5mIzK968pHb4ozuX2Bh+7tVaBQPTPA1YDFIFEHKvD4CbKP5sECHWM
 g11F7/xN7A1LiDlGL0uc3VTvCAhVYIVdRMLcv0VszLz55LxQv7tIPetqn7LBT7+UFsIY5sVzRLZ
 WvGm+cIsliRR5tlrSDcRQaXKmuPqxoDG1yNI6Rc5LNKT+LpQMadfyIEQg84g27AitBzQ8Xpx8m/
 tsHuvAvoz4xcXQpf+iavNb+zEekVf4UefIUlyFu4zJ5pKlE500WGPlOP405oto96xcPuOt3LRpc
 GcQUtb03mdieIvzh7TbqvzM1bujvyQG0jZw==
X-Received: by 2002:a05:620a:4588:b0:939:85e4:44dd with SMTP id
 af79cd13be357-93c15e577c6mr460610385a.36.1790067638993; 
 Tue, 22 Sep 2026 02:00:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4588:b0:939:85e4:44dd with SMTP id
 af79cd13be357-93c15e577c6mr460604585a.36.1790067638544; 
 Tue, 22 Sep 2026 02:00:38 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdace7941sm42530635e9.2.2026.09.22.02.00.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 02:00:37 -0700 (PDT)
Message-ID: <0690255e-020d-4c11-ae46-d0968b630ffa@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 11:00:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional: test_acpi_bits requires TCG
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260921160815.1623803-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921160815.1623803-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tkP5pWZ99rgNKCFlBUKLyEloep2bZkCr
X-Proofpoint-GUID: tkP5pWZ99rgNKCFlBUKLyEloep2bZkCr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEyOSBTYWx0ZWRfX8/wMg+r2doqm
 ObQAC3qezYo2YTZWySSv2xeoA1Ws9gmHsMTXJO1WSxuhLOpf6UPT3GfTvI3d7YyCcaAAObSh4Yv
 X0fbm0Yp0BPW3iMzMWtK0vkppqVJ1dytFEEIp3nQ8Tr5bCRBILWTqzPI7zaEa0tNklOBnGhKaSw
 yRHNYuDYWJBTBTotkKQ7rXU21NVg9UtX9i8dzlSazulyyz73j3txTR3Oi52Pc5vp4BVmJXsYLRb
 aYCHuZZAHYuIxDvuT5Op010bDzK9PG6D+bk+Vu/GT58ATcVSsuZ9QdQgTjTKmgFPK2XaQVYBkq4
 lZadfY3eWp58OW/cxJiy2EmH4WvdQHJLD/AsxxSRHJ6wxtwLIlIWCeNpZXn16Oss6pTdvQtisV1
 El5cfq4I/UBe+d5n4nZrVd6vP7QdT3UXjONhX9BiylWWKYblaVMaBmEUXFABheQOAsqfyi3bICY
 auzuuOct83y24L1/Zkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEyOSBTYWx0ZWRfX6mVpqmYLCVTd
 awKFvks+zBJ8lAF5Y9UjDKLXQXN0c/fXrFtHK11aF3zruzWDTeP8dytBYmcI+HyAcFMX2gwncsU
 9j+J1YNbhENzmpPTjUpFvzaqvFJ8t6M=
X-Authority-Analysis: v=2.4 cv=TvFzFzXh c=1 sm=1 tr=0 ts=6ab243b8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=wytsGZFW8zzu6hiwPI4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220129
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

On 21/9/26 18:08, Alex BennÃ©e wrote:
> Running a full thorough test suite on a KVM-only build fails due to
> acpi bits needing icount, therefor tcg. Declare the restriction so the

"therefore"

> test harness can skip it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/x86_64/test_acpi_bits.py | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tests/functional/x86_64/test_acpi_bits.py b/tests/functional/x86_64/test_acpi_bits.py
> index ec716d643bf..62c57d23f6c 100755
> --- a/tests/functional/x86_64/test_acpi_bits.py
> +++ b/tests/functional/x86_64/test_acpi_bits.py
> @@ -303,6 +303,8 @@ def test_acpi_smbios_bits(self):
>           """The main test case implementation."""
>   
>           self.set_machine('pc')
> +        self.require_accelerator('tcg')

Could you add a "# see icount comment below" comment? With that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +
>           iso_file = self.scratch_file('bits-%d.iso' % self.BITS_INTERNAL_VER)
>   
>           self.assertTrue(os.access(iso_file, os.R_OK))


