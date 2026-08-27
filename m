Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6419BC61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVhV-0002mT-JZ; Thu, 27 Aug 2026 04:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVhS-0002l2-RF
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:43:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVhQ-0006pR-Jw
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 04:43:06 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R76igZ3226589
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZZoq7fGj3wd39YT/btHjUtvUCMSYh+asT/eB37Pkio4=; b=WY03CkdjK+R1JkAH
 BGEO60j8H/rS8L1WDxPF2WYaZXYqlg7VZgQRdNYPXHDBAVoIgMfR+Yo3fIKQMJdP
 AzKCs6gqtw5EtDm5W9Ic6PQmUIV+MwUNyQaXATHDHCo26aD9f0QRXdjtKMaAnDjI
 d5uwc8DeMnUAi28FUKcDh6wKbYhkU3hE0lEv1CHqa1BqUVBa0kMGz/6iRUcklKDC
 pIVedoW5IgjEgx6dE08rbTlYQ3BNwd88EOjumaOJidqcDM2Y+IIgvYdKi6LXfE2i
 Suai3e19mhR86iZvSV/9H/aB4gRxWB6saT5xhTZIG5gdWQDHCBxig5AlgPvBmDMH
 m/wdag==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfrce8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 08:43:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5283df62d68so5365331cf.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 01:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787820183; x=1788424983; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZZoq7fGj3wd39YT/btHjUtvUCMSYh+asT/eB37Pkio4=;
 b=hf4TPynsskc9CYnkBPGLtDlwogHNxtlywE9dyc+1ECL2jXVDURbj8PSh1woG8m0zaP
 fHuSO+bNee+XDEABILYKAd40cdYMbVWTOuV+l4yy7jf2NIrTrJ3wPVhrwcfRiWUGb1zC
 g0pE1lR53vGx6S2MquawqWQO3ODJvDCutCPm8MG4hJ0FKSDap4mosw/WsRqUwG8mpQra
 4C4xwRLYBflS2Z+in7xkvOX3Y0/tRlf/X3DD/WGvRoHGzrxyTPSD7mFuttUVtJr2WWnl
 sbsYnRfr8IxPK9sCeu3/KEm5wDl/eEt+kHHklEVOlmUp2F3PVwLJoZBl7GExRIMXE6kd
 ux7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787820183; x=1788424983;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZZoq7fGj3wd39YT/btHjUtvUCMSYh+asT/eB37Pkio4=;
 b=E54T6YWQcRP1p9ir0MNIlE4YXNDYM+NGOdnV/P5DmeGWZ5M8CVVPaNGN2N2Fyf6Yxa
 iS143X+B18wNFqTOFcq4WNF8tT8NrpGbjFv/aT4Dh7i+MoAHSHUnxT7I3zQ0EgT3qsXZ
 6Qg93baBeAG19wvsSWLehUXnDyXLmBD9xMs635W7sOVb3hYqdsc7YExBjlmqXqX39HPo
 0iVIKMzQ5/ZgTjc13kli4w6m2kwxH7dqfS6LkTJjUPaX9lFE5gq9yxZgdvpmGs0K6gsx
 vxLaT4m8GU5ABxroM15kDBN4Aiq6Uu7dcbMpvyFjFEdmszTmYjlZCBNTS8SkdJRn/uu7
 qfrQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RorO+k69TWREbgrCUJM4jls6f3u5PL0RCFH+joRkxn7x4OYlfzXzXjGBgO6sSlnLx5//4Ikc4mdbJSH@nongnu.org
X-Gm-Message-State: AFuF++lINFc6zB21IgfuJS6O6lPt+trh8l0NVTzvQdFow35Qq9AjGve1
 O+2HxxiSIEjcYs1kHiQQ9sN0EUlxBr/xYXedexz6JH0hGUJjU5jApvZmQw+tRS4L0YVtpONVtpg
 saZIlySGK39jhpaDag0GP8zsFHldWtnlx/kYQnYBKFeToOkHVehT+7O2QxA==
X-Gm-Gg: AR+sD13msbJDIuUgiyfuyhNHBuRobZHieVaXFyDNaL4lll5ihD2xg0ioX2ow/8Pnq4P
 G648iqhOahrDp9ePS4g3C/1Wqmvz8EAaNJeHiFCbzCv7AlKuMQUvhRVJVPvCDz+uDK7CKKpGIy6
 u3wWF3/hrkNIjEpQpYfE23H2VfXBOCOkCQ6Q1eg2gNkVSKvZ0p6GcKrahgJd1eFxkPTTn15Py8u
 E+BmvAPFUVEUC89iBIeHqtF8HDP27BITSZ2Gi07T3gxMDF17tuqiiXaXxMJ6BWQc06EK71Vdgw5
 UFAcbOflvEC0gXpFTfFX53DSFLmwWL1dgz+2RAxxUO9a7QfNv4O1IUnN0FRVTOxMtNXbLLs8Do2
 OqJpACrBvoE062TzLJ3mTvGp4g5/60AJ1hu0jVZ6Z5EUDzq8z
X-Received: by 2002:a05:622a:5889:b0:52e:12e8:54f3 with SMTP id
 d75a77b69052e-52e422300damr153090441cf.8.1787820182718; 
 Thu, 27 Aug 2026 01:43:02 -0700 (PDT)
X-Received: by 2002:a05:622a:5889:b0:52e:12e8:54f3 with SMTP id
 d75a77b69052e-52e422300damr153089881cf.8.1787820182115; 
 Thu, 27 Aug 2026 01:43:02 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e27ab574sm7239065f8f.14.2026.08.27.01.42.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 01:43:01 -0700 (PDT)
Message-ID: <a845abd4-fdbe-426d-9a28-7323bea656d8@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 10:42:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 42/43] qapi: convert trivial intro sections for
 machine.json
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 linux-cxl@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
 <20260826193840.2152000-43-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260826193840.2152000-43-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -A4WMYC8O2A7KotExMmBHaNK7u0WODGW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX9jA7Q2SauNsd
 dQdUCYjnTRySVEDiP+KR8e7iY44cTpK2NbhIzcDk0CUie6xfTSeUsnIFVh7qecRp8uV2GJVDfJ0
 c3hleuNl4EoFqkvOvnPUt0EbXVTkKM4FcUsy5BHHz1fyLj37fJrfOOXHmc0vjOF/5QUWRc+FkRi
 pYqfuqNrJZ53RHv9bTYyREf17+frA7nS/mDYmZPXPC7yu5dyvQz7dZKsXjXJRuUdqWgE8ltkyye
 NilbP3xSfLtwPYseDkj1Rm2HXSVlo/cjAUsUJ9vI7J1A19UQTiBvA6j4Tj4VcVEhqNqWvBZ4U1S
 NA/hNA0q3ojME2Es0RoikyUMFxe14ubbI2pEH+TSvtaanXc8+Wrjzk4rX50uMLeW4mFj9/G+HBu
 arRMnPn1eSRi4MEZmO8CzLV3tRkqEfxjFWo7QejJ62x04GRaKovNQs4tjyb0Px+ew8KnG8RXgmX
 tLxou/qoCAE1xQX049A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3MSBTYWx0ZWRfX/j2ERfnSMRCk
 2CouhLe4JhkLNaM+fT5jqYGfdP+IB8NNhP71NVpiskULs632OaMYQaQcZ3xCyao3oSNJB+ZrfjQ
 kI7yzeWgvwnPE4OHxJgdTWPp2fLD+7Y=
X-Proofpoint-GUID: -A4WMYC8O2A7KotExMmBHaNK7u0WODGW
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a8ff897 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=UFf3ptpOQOAA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270071
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

On 26/8/26 21:38, John Snow wrote:
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   qapi/machine.json | 208 ++++++++++++++++------------------------------
>   1 file changed, 73 insertions(+), 135 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

