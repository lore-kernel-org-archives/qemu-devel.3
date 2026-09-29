Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7ACCA5FA7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 18:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBcei-0006Re-8g; Tue, 29 Sep 2026 14:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBceY-0006Ob-EQ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:34:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBceV-00018x-JI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 14:34:10 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TI3WWf1723976
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 18:34:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Rt7L6P9MdYINd8bdhYN/8GhUtPK4T9Gx5MerR39bkjo=; b=ZIjb5v4oL3DDDtdc
 MTn4E4d8tubufpb48eVERT3TWCYKppi5r/mLUmzjMIkxvXwTvy3TEZpDSuZehBsx
 ntuvSk9tDwur9VLwPNOgF6RCSZAWjF3YLo4mD0mJmO0VfsxBIv9VTjssanzg76Fn
 0DxGiKtYOFZuoZB65ifTQWmbweQhKzMYI8djzmvr4jdW0bVZKOsJEt2+uYhD+py8
 baEHAT2JgDUCKRDzGy9UqzB7Lh1Nl8VaixGmFcSVA869rG3l7CY9IlF0gV9JzpLO
 E7dhR1mlecJu1Tle9v0I3lzxy+42qgpZ4ncbkaXBO3Z+MhRfSbq6NrYk9EnqMVC7
 qE+pHw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0j97r4da-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 18:34:05 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-313d1015161so340684eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790706844; x=1791311644; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Rt7L6P9MdYINd8bdhYN/8GhUtPK4T9Gx5MerR39bkjo=;
 b=Y+JQ0nDOiwcSjbpC9l3yRLTz3DkCNb/66YvaP63PUNdvWL16E45QkKnslSXKbnEdgI
 t/dN3HBi1WGRqareHPo2nQtviuA8xtpsnJ7RG+u48eufe4niNXdfs1YU8+Xce8UUYoZT
 AA32B4hZZEJRQ4IXbQ1QZARHguFrJ7nxXBqs5XTK8VUTzp/6hZOoDUZ4LbCqzcW01sj1
 VidVDY70SZ0ZdNOEpz9aizXpaXYcaZnunUolBYJ4lRW0L27e3L2b2NrGtJDTcWO244U3
 K9z3/nryxDpizSGvHhM/sMWVLPa1Y5bwmfZPjq51xYRFt9fuL+fGhAuwOvNfL8Mc45Gz
 Ydyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790706844; x=1791311644;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rt7L6P9MdYINd8bdhYN/8GhUtPK4T9Gx5MerR39bkjo=;
 b=1Lts9yH/GkJkBtaEeeorxYqJ0HvJIceXocW50t2vBl1ndnGJlUAZfc0nOwi4cUbQDA
 +PfTPICD5EjEAhSGfrO3e1xOIH7gkzjJcAnVVLzsOXIZp382RLPcHeRaeO1HIk7ui3js
 a+FoVaDLPMr5wl4QmsgW0HdaIhZRfX7BP28tulEtNvnR0lPcxCKl9CDhEw/A4Ee7ZxL0
 hpjr4No4AlNYtWHEVKEor6I9s4GKn6MTCD7ibMvl59H0treJrBfrAC9kr/24RbP4Lt1f
 5Pj6mVdQsF26eDoTtzFvwliC5wHtQ3eYu6t+eW15ALnAdYhs++csaD4kmmHowaD3Q22D
 yGNQ==
X-Gm-Message-State: AFq9FYKA79i6JP+uoIQQxtxutOj1izQzgYjb9K0nxtMyhCiL+0HT3X3M
 8bisfsYOERmbgZ5z+YofC/BAm7rajb6b7usCIj9SS+IlaM9OFFbU3pxM1+zFLtcND+pgPW58TYd
 KiXTqTFarOzfSTpZRCtXUhszjNsABwigqo1mDMnxZUUDTs53pWQqjO9rKbJijYsYCZQ==
X-Gm-Gg: AYBFou1FcacqzY9LWT2HNN2VsGWKQZN0CNo8ZLrYcWnOqJ9v/flzYvvVyazXZZB3MWX
 5tVxpxKTla1U5m8YzS6EfU5LPX3DWAKjNacQnAU49c5z9gC47UH7NvkHq/sbhmdQwqfMQp2llgi
 MgvKeTikk7RbJAMSea7qD1cgWnz8jR7gBYdnA9R2Sb6dfj48Pcj5+3ERqGFdoXTykC0fPW6kOC1
 mfD+oEDzdJmp0hTuV+EBWHlP1pWK0Hr3ck6nYLUvPM5LuYmKK7rmbatIDNczM+fvltQw9HXjj+X
 /YELZIB8wQQ/p0vY52vMEHw77E4SxYkt9OsEFzuoft/4MWcONtPrPJs7tevgaKmSQ2QkgRNVvk1
 5YbmJBp7DgsPRR+Qyw5wgNfuT8eopSKqW/Svfbh4c3XZsEDytE2nKdwl2Cb0CB5yvXgT5Cg==
X-Received: by 2002:a05:7300:6028:b0:33e:4e63:5d80 with SMTP id
 5a478bee46e88-34c664379f4mr214627eec.11.1790706844204; 
 Tue, 29 Sep 2026 11:34:04 -0700 (PDT)
X-Received: by 2002:a05:7300:6028:b0:33e:4e63:5d80 with SMTP id
 5a478bee46e88-34c664379f4mr214548eec.11.1790706842077; 
 Tue, 29 Sep 2026 11:34:02 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388c76c1sm945443eec.19.2026.09.29.11.34.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 11:34:01 -0700 (PDT)
Message-ID: <cb4e35e8-d6a1-4c3c-b166-2b0b75b89a61@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 11:34:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ci: add multi-target job
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260929183320.2960-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260929183320.2960-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: zMeeTcjtnFMmHBDuUM4ndfkm3o7K2KdO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA3NCBTYWx0ZWRfX8I0UpQlqUSB3
 NPxBBBkH5s36ia8RjWCWiGOsYyFrRWJvwQC5o3q7N1XgFHIbLSKeF+dESw/7++sCIvtdoiLgH0L
 n3zP4AHPLLzbjl2M+fJYCLujDxQBc6yYA4bfXdQXzd52Xys97uTQlyLSTQLgUkthyeavjKJx32N
 6Xdqq+eXDLNJY4QAhcYzdbCUSSMXszhbfUigDsp7m0WGvUhWLEdZ17xvjzIdlumIiAF4SZHwCEm
 x7ZRTgPhkJIzXySi755T+Cj3JK8u9WQo6FWJkLg1PZUboEqMJe63+752gsJcSAYKW71qbk5b8ZR
 D1b06VbwCSVld72PEyI+siq0OZAXeL/nUC1QySmk0l09mOCk2RwWKRs1sut3OMQWp8RzWzImyqF
 GPzEDuhRffB1oLsq/prDMlPdTh1AhKya0IflgxDvWmDORVzgVBIMcERyH69LMsYaEhvIQvwDvM7
 kYRid+bLJsbkBmHeRIg==
X-Proofpoint-ORIG-GUID: zMeeTcjtnFMmHBDuUM4ndfkm3o7K2KdO
X-Authority-Analysis: v=2.4 cv=BPImP1QG c=1 sm=1 tr=0 ts=6abc049d cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=Zc1SCy679kIHIr_082gA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA3NCBTYWx0ZWRfX5JzslixeXKWX
 4XzKiJGlOp0xh+WradbXzkyvJt8U9l7DaZZ8H9pgM6cYla67gE3vV4Ywud/H620nDCJHlqYI7Wf
 WGTxIzXCaak0k2Zbq1/+peRCN+ruEBE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290074
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

On 9/29/2026 11:33 AM, Pierrick Bouvier wrote:
> This check ensures we don't bring regression for all targets that can be
> linked together by building multi-target test. Also, running it ensure
> all QOM types are unique.
> 
> All compatible targets are automatically detected, so they don't need to
> be fed to ./configure.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  .gitlab-ci.d/buildtest.yml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index a97cc0b20b8..b1e95395d0c 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -659,6 +659,17 @@ build-tci:
>        done
>      - make check-tcg
>  
> +multi-target:
> +  extends: .native_build_job_template
> +  needs:
> +    - job: amd64-debian-container
> +  variables:
> +    IMAGE: debian
> +  script:
> +    - ./configure
> +    - make -C build tests/unit/test-multi-target
> +    - ./build/tests/unit/test-multi-target
> +
>  # Check our reduced build configurations
>  build-without-defaults:
>    extends: .native_build_job_template

Please find a job run here:
https://gitlab.com/p-b-o/qemu/-/jobs/16816899262

Regards,
Pierrick

