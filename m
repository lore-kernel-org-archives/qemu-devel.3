Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20227606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gRyuYSlQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gNBEJgIs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLyYM-0002Mv-TU; Wed, 28 Oct 2026 03:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLyYJ-0002MZ-Fr
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 03:58:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLyYG-0005JF-Ha
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 03:58:31 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4Q9IS2753512
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 07:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rhvGInK5zgI1eQ4J9LAjRQ2bzaVQYhPb/C5AQkVEQgo=; b=gRyuYSlQFmBoGm1f
 faSRooSnfI3yO4w3BIFpy9cDdTlLeYuEfSJhLl3buQhgyJdhZfL0+dNdXrxB4Cuy
 gDKETFo5QavH+RqofMcKr9ofz9Co4ahulGJZwseamZakXHz0ZjyHuqrutcxAgajE
 SYVt+ONf14oZMfkOP9Zl+RJfbULMtnUXx2a8HtxvTr8mVW8t7fJKBAZlaz3Cc3ET
 vNopJJ+GDoQYBvZ4JGtyHMKPRI3/xJ31TmQuCseYwh2CvjrS8ZcemwmLku24IoU/
 V+YATyFtGzSfv2NhQOk5zVhr2BwbxhaH/K+RG1O8Q2quVdcKB2xfptlU8Ezs/iqA
 m4rTOQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy713593-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 07:58:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ca9b53afaso178683585a.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 00:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793174304; x=1793779104; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rhvGInK5zgI1eQ4J9LAjRQ2bzaVQYhPb/C5AQkVEQgo=;
 b=gNBEJgIslvKrS6UMKP9hiolOChIgeMeAV1OLd3rNdnNP1p5i0oMHU9xiqcOndqSAfv
 SXrS47+o3zUGiqEn4uP0ZgNnJXyxCj3bB0rlYBRyucqFtoMNwdZd6nxCbreDqgEyqizL
 G+1xANCxIfgbTz1b+ikdCYOjZBnrrWxUAFIn5RfeFBk3BT4HHjshHJQKnCjYldxblNNi
 solW8PMGxMvMtPsb3sXxgd+wrlxxBwIeLg6ZobQykRfjCaPgocAPX8rfkhssUUBNe6Ov
 p/ktlZB9Y7ujR/CVpRtwp2/BDhfuxkULxYl7gtAkEqzPZG6a+epHVcDGvVujRjmCF/MZ
 N5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793174304; x=1793779104;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rhvGInK5zgI1eQ4J9LAjRQ2bzaVQYhPb/C5AQkVEQgo=;
 b=NXhh9kufOw5x8Aw497kg2m4Xc5yYRfLfRJXs2DABX78JHVd5wr+LejuM9xTfmCmM8s
 KtiMHuPUlBiTyeWa+H9ndxu4d9Klh4YJVvSewoZfF3Y6+cC8QGZH9iR6KwXbVmW+0NRl
 ehtN9Znf2yj5bfBcpVDEnC1YQwuyNjMgXwn+13ycic8rrqsaNIRBJW1uO5DM8ZPz2uXN
 cCWG7iVa90XBGrduTjGQnxKd0ty7lz0gD1Zbz+IvhPiirDIKQf7qhISDIg8Ee44XtKa8
 l2szLtXSroH0LqMLXQZL0dP4kpKcqSdI4M9O99I0i4qxgK1dT+y5JNn00aJEdmjuIYyX
 j1gg==
X-Gm-Message-State: AFq9FYJ9GmfOb4q7VqZKe4xAwlpeDnTL2NKlaQfW3zcxbQ22773HcXhV
 JBbTuOznyXzl4s70M6fBoEYC9RtA568Cgl3hSH/a5NwDWONVckg7ZXP57o5Wo23yakCpi2ztlMQ
 H17BU+RWLFmpc5bH/Nzo++7+BVOHXN7eEtIfE1dq6rClF0c5tg5tcIu0wfA==
X-Gm-Gg: AYBFou0Iu9UywY0Hj6qFZmfL4pPI5CgkqlkyBHCEUr/yku6B5UT9kfXzeXH1YviPCJZ
 660ZSiXYdk7i+jJlxp7Q8JFhduEskqHpVmmpMUrW6ZC0xJQ0gclG6JT1PbSvmsVhNoJVYJaRzrg
 7UJXQmjpV6N4LhFjyIlKdaX9ZPBQ7l0Z0xRmrPSU1o57vfqNF0MDEMaEnD+HynZ5+6QEhq67Utv
 yjt+quq8Aabqg1veR1XStWVFVoqhFo4x4wkcxOsVYb513rxOZg20Ir0y7la68GC+B4bKfxhQJUD
 GHTPmyZjzsb7WBQjKCsxIl5v8b31Q1he54YTzGC2uWxSndODAaxAERSuxEWg6engitPKOge8qLk
 ZX474+5UVowJR71JZYbscSyTPOeQ3vFgfFPqBApj3PnSY5vlcwMdhf8AZZvWf21GwcSj2mU3WmI
 S2xm9ouSonBCnJWamLXYT5kTs=
X-Received: by 2002:a05:620a:31a7:b0:940:f53d:5f7 with SMTP id
 af79cd13be357-94408debc40mr205401885a.69.1793174304150; 
 Wed, 28 Oct 2026 00:58:24 -0700 (PDT)
X-Received: by 2002:a05:620a:31a7:b0:940:f53d:5f7 with SMTP id
 af79cd13be357-94408debc40mr205400585a.69.1793174303684; 
 Wed, 28 Oct 2026 00:58:23 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc4d76sm27424057f8f.12.2026.10.28.00.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 00:58:23 -0700 (PDT)
Message-ID: <f81a624d-73d3-4de2-a17e-2bfad705a677@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 08:58:22 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Junjie Cao's email address
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Junjie Cao <junjie.cao@linux.dev>
Cc: qemu-devel@nongnu.org, jic23@kernel.org, anisa.su@samsung.com,
 linux-cxl@vger.kernel.org, junjie.cao@intel.com
References: <02d394e6-eafe-4a3d-9f63-61b639267aa8@oss.qualcomm.com>
 <20261028021551.498530-1-junjie.cao@linux.dev>
 <20261028032407-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261028032407-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzMSBTYWx0ZWRfX4igk5WbzOxUs
 Vz5oA5tXMxjcBPrmC3lUowfeaRPuXqa9v7fAIKH9MECKZ0NT8DVUGc8WH19ACtyWlpmBnLA0M/8
 jNivXPEgzLU3Vq8ZUaQ/V9Foz8Z0qojvyiw8vhsa5aIuV2ymKTGDotTPqF5am7Xt7aJPwD0N2CB
 Omcl1FmB9iWu4nkWD+1xXNfOi+ooKorcjODrSp/JFthmt02YupN/G/AfyFLB3cY+2A25vmJCyRs
 0vUvwlDyB+sHoltSvk73rBuCf/GSv6f4Kq7WStHUZr9oBxb03TP8p1VOlvloAj2txTE5xId96l+
 1f5dRYGxQYAfsgdToiRhRPj1QwxcIigYmeyxp67sR19DtI9fBj05eC1CBSXI08Zz79+ycCVTCzM
 sS79t/l846hqRfZFHJUJIliXR61WAt4dbAmnDcko6goe/YAKOWJ6QtAgmy9GezKRlgx3Zc3AugV
 ve414ByS13vwq+hhD6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzMSBTYWx0ZWRfX7qtHb0oyYL6q
 VSaIwtluqRr8xkxNh1xSnIlR3UHWfdg0KYr2HSlNUA1Rez6bRUlQcwhKuCX/TTEknErfweLZhxm
 fRF5TaovWJTUL3XyUKCsb/eM4bXgRAY=
X-Authority-Analysis: v=2.4 cv=JspkP84C c=1 sm=1 tr=0 ts=6ae1ab21 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=Zq7r3Ef6Bm_1TbWsCMMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: KMKWf0QeUbWsFNtASN3GchuBhuJ70uZt
X-Proofpoint-ORIG-GUID: KMKWf0QeUbWsFNtASN3GchuBhuJ70uZt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280031
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 28/10/26 08:24, Michael S. Tsirkin wrote:
> On Tue, Oct 27, 2026 at 09:15:51PM -0500, Junjie Cao wrote:
>> Hi Philippe,
>>
>> On Tue, 27 Oct 2026 19:20:21 +0100, Philippe Mathieu-Daudé wrote:
>>> On 21/10/26 15:43, Junjie Cao wrote:
>>>> -R: Junjie Cao <junjie.cao@intel.com>
>>>
>>> Could you Ack from your other email?
>>
>> Sorry, I've already completed my handover at Intel and no longer have
>> access to that mailbox.
>>
>> If it helps, this aw99706 kernel driver patch from August is
>> DKIM-signed by intel.com and has linux.dev as author and SoB:
>> https://lore.kernel.org/all/20260804030255.1934470-2-junjie.cao@intel.com/raw
> 
> ok, will apply then.

LGTM now:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

