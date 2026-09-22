Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE51DC982FE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 04:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8sAe-0003tt-Px; Tue, 22 Sep 2026 00:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8sAd-0003tf-8l
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:31:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8sAb-0005KC-Ol
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:31:55 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M1B4Mg2174209
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jqskswWwakuujvkzTofBvuNdMzi3RRX3jH/XmKEU9r8=; b=Z/u9UhZ/rsu5tpRG
 s7xTrJ9apFetyZSQL0qzYjQDSO7VnSg2CEpKpYAew8mKTLTueFPJn3sQClxsmIjE
 gzZjRYvVnYUn5upsXmbtMR6FQlFxNPqq+KaN3oImdQhgBBogZL5LAeawlVTrIoTZ
 cLjEJNFZzg85nArtzAm4f+xomC5ZGVQAZOGqS67ZRpn5Uz+I5IOiWXZhYGO7x8vE
 NEpH8ixvUY9HCygyGWcadwNM34EfqTRmw36+pZh0p9VccHrECbAzNlA/IrAM16kB
 xE1iSntoTCLG0Tc1VL0b5x0MnonKXMV4k1NlNwtwnMl0r4IglS8G6syAICZmyoBr
 l3X7fQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufsq8kgr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:31:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934956beec8so778927785a.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 21:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790051512; x=1790656312; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jqskswWwakuujvkzTofBvuNdMzi3RRX3jH/XmKEU9r8=;
 b=Wtr8kSo2MUFtA5R6QCatLD+51S7zuZr8u3rqVATj/iWonJWYJMM6Y2loNzeNYFBae+
 JQG1exTKcZzjkNQiHIYhLaXuzju2PvL25eYrvSogW4Skygw6QfKVVME3BcwzSow0EQvo
 Rsdvk3ICuOIBZd2duH1oTsUYBjMOqgJdE/elOPhJIawZsRdq0MHh0Z+mAMQrn1eQWJkJ
 iQFaa8z+a8mUpJKWsdBCJDHPi3zSJkSBiYwclmqq3lePGYdAkZTD9WnK4NhL/avmbfli
 VlySChVDfC9ZpsFcxX+ld5SIOe8aUrShR4tf9LyL5G9teNnbUBClUldUBxIzTuC53kRO
 +ymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790051512; x=1790656312;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jqskswWwakuujvkzTofBvuNdMzi3RRX3jH/XmKEU9r8=;
 b=V5y1fYcUXh4o3JV7T+EZdr1lA1ETYz7ljst5Yuoam2DCLtD8TA1+aPq30ZmPEGSQ1M
 LwgLszVR/ct3GAiypPAaUV2nuiWkeTIvHQYOgVfGANvexPr9wf8Z4m1ieW7SxGRFVQeX
 9ppgtPJQVdrm3KkSxa3V0qKE9NGDuas19BCVQz1NMdM2IlkY330cOMEI0/gb9AR/ugo5
 7QcoRo+eV9b9jk1JgO/pj1vtUNf18c1ulqvpj4+0pl7YUDlO4tfjR7P5fBWDB5jJtZpQ
 Umfhiz6vFP2kqRmMZaone7a0BfGAop6Ez7hgmlA4/3UuQB7LWQiiUTMS/VXin/VSYFcp
 RCRA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwT5HoEPNcfIHrwkIxpcPHa+CXfNKwhfLiYMT9qHGPueRZxfHaDHA5n1hFRKaEVZ8zuR9RzVwqHLwTb@nongnu.org
X-Gm-Message-State: AFuF++n0II7FjfYd7IvOrpLPlvsET2RpQLKmYOTAtXhRzXEW/uPNFefv
 +uL/+9Puya05HyNLcsfbUX9TR1U4sjIlSqzr/IojbN4gjJgVIHVTKHD817G0VeDvLcacdn36M5u
 NhYBEPRNcaxHCh40sN/EzIM4F3zUYwH3/VNaPhwkmI/a3+4AnVwGpxqNUNg==
X-Gm-Gg: AYBFou2EtNDed+UiY/mJP02RRzfJR4Ws53yRCLvLyHHh4edrrls7hL/1n+Pf3E7UKIA
 xVj1tPSjSHawn/+Lzu4wNVpOG8Hv38f4pwCsOKWftbCwORs010smwbrM1v1SkNmZR2PJlc1wKck
 tL1TtaZnmf2zTiNOTGhWmXDtGhbHvvgMIrHPoWH6JxFyDXXdA8GGynFKI27igAF0qXRNDb+OFzR
 z9K3V7A/Ff/9nQxgNt2nwAMDtxGG/urIbugUsHe4cWc5UWgaDpLu4Q1sXmV/kAcqk/z9UiFuTMh
 KHlseqSpY0ZO7eYR/NOBVmlE2lQ4CXKoW0NYDa1n0aW/7PyofnM2h7XAHmQcnARnSoTJsx8Lkm3
 13ROwq5dyu5J3EnZc53Amz2U/tENBtbrc+Q==
X-Received: by 2002:a05:620a:4803:b0:939:f5c4:ae5c with SMTP id
 af79cd13be357-93c15e5c4camr369228485a.43.1790051511885; 
 Mon, 21 Sep 2026 21:31:51 -0700 (PDT)
X-Received: by 2002:a05:620a:4803:b0:939:f5c4:ae5c with SMTP id
 af79cd13be357-93c15e5c4camr369227385a.43.1790051511501; 
 Mon, 21 Sep 2026 21:31:51 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8ce2623sm55611355e9.13.2026.09.21.21.31.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 21:31:50 -0700 (PDT)
Message-ID: <c1823185-454f-4ffc-81b5-cdb1e19eebcf@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 06:31:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] tests/docker/dockerfiles: use docker.io/amd64 for
 tcg-tests containers
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921231458.3369-5-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921231458.3369-5-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: F9iU_1X2caOeoCj-bUWWw7qeRcJPinfK
X-Proofpoint-GUID: F9iU_1X2caOeoCj-bUWWw7qeRcJPinfK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA2MiBTYWx0ZWRfX03E2Z60rlm8Q
 xiApE8G4XlTDBqtoKYeLQnPHTrQUG+qvFhJP7kwbOU9hBecBe+BF1QcdkQhAC6Aqe0Wb7bz93D7
 GDMTYpI5Pavl3B6ez6PSEZPlb5KXGIc=
X-Authority-Analysis: v=2.4 cv=NKBAaE6g c=1 sm=1 tr=0 ts=6ab204b8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA2MiBTYWx0ZWRfX+lHN3zM9GHJR
 jPdhDGSooYnhQAAPNfaxKJUGaWXGbO94QgEINgv+wuXG6a75t7rCJPZPehxZPJa30tVmVgVKjIx
 t/Yxzo4JmCYjGIJ+uRtUmWrEoVs1kGO89zB99sEj/jRQeURWnzTBOOFZPwjuSGUG4Y1QikfBwjg
 YSOD9CXjWjjSrYqH43z1srN4fhUQ3NZErs6cY23d3zRl0BEPsjYjrWmJODi+oU/Foj1qkF0kn9H
 ZBuavFM9daqznFdNWOiydLoCrDLR7Yzk2ks25pphBy3V+eYvJkYXvQkaEsY4Xhl84BLHxxbP8h/
 3ZeN+lS1XG+xAehqY0Fsc+8MilKnCWw0HBq7+s0vPbiil8kW88CqBXkjw7PdMbra09xuQ7qvkew
 t9iCdCYIHnJ0NWoV068CLvz41xoQi1iNaE9KhvJ/oexWHa3H22VNYwqs2BiNShZFbFFDmJm6H7K
 LnlyTeyh/66t2KswDOQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220062
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 22/9/26 01:14, Pierrick Bouvier wrote:
> We now restrict those containers to amd64 variants only.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/docker/dockerfiles/debian-all-test-cross.docker  | 2 +-
>   tests/docker/dockerfiles/debian-amd64-cross.docker     | 2 +-
>   tests/docker/dockerfiles/debian-hexagon-cross.docker   | 2 +-
>   tests/docker/dockerfiles/debian-i686-cross.docker      | 2 +-
>   tests/docker/dockerfiles/debian-loongarch-cross.docker | 2 +-
>   tests/docker/dockerfiles/debian-tricore-cross.docker   | 2 +-
>   tests/docker/dockerfiles/debian-xtensa-cross.docker    | 2 +-
>   tests/lcitool/refresh                                  | 6 ++++++
>   8 files changed, 13 insertions(+), 7 deletions(-)

Thanks for cleaning this, this was annoying on arm64 hosts.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

