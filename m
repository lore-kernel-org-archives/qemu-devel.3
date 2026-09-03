Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073DFC624DB
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24sq-00078D-M2; Thu, 03 Sep 2026 06:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24so-0006p4-MQ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:41:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24sm-0006ja-UZ
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:41:26 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AH7N71328086
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PRmI+SUzg/bNyeKj91d9qtZWpkTqY3+xge61JaSyO60=; b=gBuBDlwjK7dhnCxm
 3uK74VPrOjnlYSfZaEOOAD1BJlt1SxlMm+5kHr03IZ4zyNR5gDcuZ7PgmQzoY7bL
 Vc424YWbtK+3It7tOOZY6FFJ9hd1cFF7gpSdyUobXDyTU95WWOAGLZk/LZYQTL6d
 LuPXM56uA+jcx6OxmOEFz3gnWrZgOsR1shMsWS1EgXhEeJgTuT0q550kIXFCzGRT
 P9O4FwlEx3w+8ki787+vElYXZupGpYdKWXa+lPi+iHjQ7Eg7l2rgx5cvbmiybJ6t
 K0LAzO1zZcfJ2NpdD6bpmYoTJWdkqsGWFeLz3Bij5Lwb/a+L5NWVcYjOtDmXqouH
 4ycHyQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrnmm1x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:41:23 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9375d92d8cdso490602485a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788432082; x=1789036882; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PRmI+SUzg/bNyeKj91d9qtZWpkTqY3+xge61JaSyO60=;
 b=Cfjk9pAz+YwsKkb0B4wiP/4+z0OarMVPAicv7CmiRmAY4BpREWCniVOkdkurkF1X5s
 2atZfSux631ne6NaqVCmCQiURFeWjXl4of8YlEiR4sXrkBzqMgDyLbJmEqgSKYE5iTl/
 YTRoRtIgQpbmsP5PZHMacET85AteNV2jn0pHD6jEdPIqhwdOdGRJwowemteveme4jvbr
 Ia9piNYjBKCSKElEzt5O/fdN9tacxaXjqek/popYdbEOMz2DBP0plYd5XtUgRLYXvTNV
 n6X1DM38OgI3L79pN58cuYsmn7EuDFn8E+7yBMdUTSoJC5gYcKsBfahANB8wwk2VMMNg
 SNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432082; x=1789036882;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PRmI+SUzg/bNyeKj91d9qtZWpkTqY3+xge61JaSyO60=;
 b=gAeiKKY6Svo7UdekTFFvIEPCSdlHVN1jRKz9bOV9TndSPJjOvBj55MnCbW7r3qCMwa
 p9Jzy632xA5yluz/gXwtzGx3VqG/GLXy2NEOFUTdXPN4tdxd0MlTFMSN0w8J84o25Dhc
 mkkfqzbYMHo+tgPaXHlYBItt48CrKYOST4Er+mwu0n8apuCH8GqSpgDPBKK1Jx4mEVYt
 FRZuREF6rsgc667OM2t7Jh89LnTfncadHm2zikmc3hkB4gxU0l7gmw8w4l8mtSPdqM+9
 VCzRTd1C5ewUz4O2g4q9SVNr0uDU63lFAUjkwY6dqnWCYnm8wfUXKlLvBVWGCljDB2O7
 VmTg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnTh4hUymCKconvxZyKQUyfrGqlXDU71op8iZHRXdlDKN+bpsLFUvKmS7URzFUqU5BfT5xeMqsc38S@nongnu.org
X-Gm-Message-State: AFuF++mmLDWAR7aatWObr2JnLTbMH8menmiSIBCmCPLEz+lhqMY6zFz/
 C/3pEJEBRJ7XlzKWLZ5MOFIH/iv8WV3WVcXDN9bC6zB0okjoX7XiKJtXOIEneR0APvwzwRjIFjH
 lzGINk5qpOE10ia1b/nLCXDg2n2ceAoTpSLVec7jpbH/uMzoEhS0/EegmuA==
X-Gm-Gg: AYBFou27rgEi5OUrNCEmg/shh67cUfO8fpTC83/p4B7j3Q+lKfthf446c7rpou63Y8T
 GHPA3gWY+t51dRXTBp082CDFHSIpJQSqfBfBhP7LCreyccMJZbZrPYZoUHtUTbHf8LUioiBcfpm
 HeOWjxKc4rXiqUN0x+RLfskaacN88btqrPI+UmmCMCMKdJ+94aCdhK7/PL4EFcuJdPIpLU0XG0w
 HEN3H9FSt5nBBj8NUsHJCv/6u6xQs09F3SAm2ZTDRnJ3Wnb4mmuGSdFEYfosyxteHTsc9rThtE7
 IfGSTrN9s3nOiHPyPmGqqqyg3y34CldexR4OFw8Hl7EW9rBPqPr0xYlYxfIK54y2lWTi2wKVca1
 CaMphQgcWGrrWxnrMxsf94kQAvm4vbb7ZFQ==
X-Received: by 2002:a05:620a:29d2:b0:939:6de9:4cf9 with SMTP id
 af79cd13be357-9396de968e1mr569377185a.44.1788432082549; 
 Thu, 03 Sep 2026 03:41:22 -0700 (PDT)
X-Received: by 2002:a05:620a:29d2:b0:939:6de9:4cf9 with SMTP id
 af79cd13be357-9396de968e1mr569373585a.44.1788432082182; 
 Thu, 03 Sep 2026 03:41:22 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee3b0af8sm62439245e9.0.2026.09.03.03.41.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 03:41:21 -0700 (PDT)
Message-ID: <0dd7b4a5-e45a-45c6-8178-80fb11a46c9a@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:41:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] meson: bump min XCode CLang to 17.0
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260903103548.2142568-1-berrange@redhat.com>
 <20260903103548.2142568-3-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260903103548.2142568-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RtfFPNb0WFNF8hRxxTXM9iywsCa9PJvJ
X-Proofpoint-ORIG-GUID: RtfFPNb0WFNF8hRxxTXM9iywsCa9PJvJ
X-Authority-Analysis: v=2.4 cv=YKuvDxGx c=1 sm=1 tr=0 ts=6a994ed3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX2dDZfB7xsgDi
 0jHHusHGeVR7RqPXFeY6Sk+hZSjpnM3Q7CS1BZjGbads5WCMG88jqS9uH4xCmUNtwrjgCiVI7nf
 3tDC+VnfDplY5fop8SqvL4RC6LQftaF0OjI9UlBBbtXfZ8jpgiNbGnxOatR8559r1l1pXUNjwTi
 6rCLae3Co9MSnG7ztymH5+hFMJ/R52IEbEE/LgUMgJg0r4se6qMeHZkrr5eX+JlSBYZDe3/bh1m
 XM9741yUhxv6+bQfVPiEoUfIJ27NQfr/93TS+3JzTnu0rT9fWHpRMA1xMEXMyPr0gRMHrx5i1j9
 zKJ26VCT8ZmQrBKVdJXohIUcqixamzgZ/SjcYoiV+YV0r7/nnpWTWxv/4lOQDdOc4GOtM9XKyoP
 tZxOC6DYFZoYINlBIqIlrZVb/W/IGVZ7w8NxXW26I9oGHK993Rzn7hbL6z90mjXmSHu2xoV1hOG
 6TxXdbB5++AghfN8GEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX6gmzYCjIoa6L
 fJV6AlI+Bzfdi3Zw23BjMgUNE3aMRF2OrO6kNFnVVhCiAxViuYCRir/Gm5Ll9bM7MmZuju7Sm5+
 nRg9ypeNQKzLFmmxwe17o2F/mR5fQFs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030092
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

On 3/9/26 12:35, Daniel P. BerrangÃ© wrote:
> The current two latest macOS releases (Tahoe and Sequoia) support
> XCode 17.x, XCode 26.x and XCode 27.x is in Beta.
> 
> XCode 17.x reported CLang 17.0.0, and this continued with XCode 26.0
> stream until XCode 26.4 switched to reporting CLang 21.0.0.
> 
> A min XCode CLang of 17.0.0 looks appropriate and matches our current
> CI job matrix.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   meson.build | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

