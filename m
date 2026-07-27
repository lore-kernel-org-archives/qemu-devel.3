Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE623C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woFsc-00041J-BH; Mon, 27 Jul 2026 03:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woFsa-00040Y-NV
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:36:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woFsZ-0007Vc-BT
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 03:36:04 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R7RwSC3231808
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:36:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QJpte5YIDNjq3iAIflT/M62g14G9xuea3VgFhoobUvs=; b=GjKqcG0ssHEfws+n
 WmXcnEhsnUmVKnyFAJShO+zgkcCx+RzTKzwfVz01f9PjUyEhztn4r5Yr1Fz5c0o9
 wV82z3Yfmmi11DoqXYuH6dC3NSxKepDGdJv2qbIfFPaG5nLjDLvpnzSqJyHuJbCZ
 +YFCk37Ca3M/QJ/Vpsf8wOnnwogDcTd/Ym5z0lu70ZUFVIBxnc/1OBqVE7Qkq11j
 sxZ5iVEFw+wdT0dK6ZXPTz6KGJCzZRdjSE0C7Gmk1ke8FlUZgO8UiRNtApXdNkAR
 gK5QJhO56l2c25WOC96SR84AAqtPW/bSwFm6SLksQsRLjHbQqeR/AeNLhbOxafoI
 T1Qnig==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmm5758ee-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 07:36:01 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-90410c668adso33304656d6.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 00:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785137761; x=1785742561; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QJpte5YIDNjq3iAIflT/M62g14G9xuea3VgFhoobUvs=;
 b=U6ddjvpplgG04f1pQ7z0L/vyPcTg3m5R8b3xVi0/M0yR3FoGlT00JPxk09K318Bs5g
 WyyEQBClZuPCU0XK1YG3JzaMICPcwwM6phvY/Y7Z4ikhgd/DqlmVqoZ8wV1fgH2lIPoI
 0qMsd2pi+K8CL7dfxYW5yXjOewHPfRU/K7q0vcxNaf68TtllYD+/jpPbf6iw3xSOtMSN
 KqmToCh3cdGxFSzrJWOUn3X0IA6v3kxpBIVmdsZHYwUh+SIei52vfXDVMa3BKgyv/N3r
 0M5h0yEZolAwsfLGb7GGy7d9PdLEab4s9tdOp/IRxqEpfyvZnm7PkLZu2FVaW3NVfI7C
 SjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785137761; x=1785742561;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QJpte5YIDNjq3iAIflT/M62g14G9xuea3VgFhoobUvs=;
 b=SqJJB5QKSkPFVlD59JxFxRICNmKYxkMVDJa4+A9u6/jUnbqHOYEWKNZrVOHEHIGRVF
 QH6OKKIgJ+auV9tfPKuBIrPXpt3OEHUFToOQEO4oxNGAjpBUHefWpdkyFNQvxZ91fTOA
 MJFq8Hzfu1ZDl2oX/isE/KoCKUhgLP53b60PldujEg9XpQ8F5smLsbhzoN5Jbig4HHvW
 +1r+AnBgL/a2mJbGGtnBj4tyhIcEGEeGe3JkTn/6D5D3dtAVPayAIkfuoTzCwyOmBVCI
 NvUtqo2EnzlKuAehEuqm124DMEfkfiFS7bIbadK1LvO7ff+oUq/+fX++NupqSi7MGqLN
 yqPw==
X-Gm-Message-State: AOJu0Ywpr5R9pvPu245axr3dNpJAMhqpPPrSn2/VYmh/pptbFqj+95+N
 ht/sYZ7jHbMPDJbzTFVr7tjQWubbdGIABOZ6zUyqtDroYU5XMDduxujgbICIOkwx6AaZDdiwRro
 YRnqGlpEym7DyGtV5qEo/XDWqZYrUxxUZLrdLoPwM781Q4E5RvsqDsOWkIQ==
X-Gm-Gg: AR+sD13A7WutC6vBdmTFGhNloDUW/zOk5e1pcT7AZOQ3stfoFdN9CZjpjBgyapABzcG
 cLZMX45aprzvxpHvs9M4iqA+/CGX8Av+mNROX4YTSLRGXRySdEoL3UdN7HdIdili2EKW0CP092k
 dwyNu9lJ1MzpcTXKOVL7mmbtqMhUyE0wt4xNmGeN9GyTVuiAcbCnt06l6rMH5dVmNCXYbV//UTe
 NVFsWA4nKmMoVEfq5HTFYqPt+yAVWHB4wodBWp2/QJIYMTL1byyKuifT72XAfk8lBsU6UtJQCVv
 xxzZHC5UhLjFwGrRureDJIlbxapYn9ncy2urNi3Nl0JILsvELPVbrENTBqRxxoA0syXHi8yrn2c
 GIy7qiIjJQA9AmDVAhguSGvBPLcwP0Bk2kaAIdHhu/Ba+/v73bBk=
X-Received: by 2002:a05:622a:28f:b0:51c:8fb:fa45 with SMTP id
 d75a77b69052e-529a86f86aamr81553021cf.58.1785137761071; 
 Mon, 27 Jul 2026 00:36:01 -0700 (PDT)
X-Received: by 2002:a05:622a:28f:b0:51c:8fb:fa45 with SMTP id
 d75a77b69052e-529a86f86aamr81552761cf.58.1785137760631; 
 Mon, 27 Jul 2026 00:36:00 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b5ed646sm218249865e9.0.2026.07.27.00.35.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 00:36:00 -0700 (PDT)
Message-ID: <b5c45dee-1bb5-4073-8079-3435225a48d9@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 09:35:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] hw/cxl: fix invalid free on early return
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-5-d0c4831ed7ea@redhat.com>
 <20260726164738-mutt-send-email-mst@kernel.org>
 <CAJ+F1C+fCyazpGfof9H0_n54FMy3LX6ujdmTcW=gAmhFz8Lk-w@mail.gmail.com>
 <70e1a2db-472d-46f4-ae27-ea8fb4af6cc0@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <70e1a2db-472d-46f4-ae27-ea8fb4af6cc0@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA3NCBTYWx0ZWRfX+7a1eM016PyH
 iJPcP3rPs0YAEC7S540hYu/ifeAK3iCUXqnK22N4XuLrG0MKhe0CQ8AH3lLgX27CGCk9oPRRXX0
 v/swymMlzbfZsGyzHyuK70Wg38LDgWw=
X-Proofpoint-GUID: rBotP_Z1oGaqq4c3vdM6rgByPQF8s5sQ
X-Authority-Analysis: v=2.4 cv=FOErAeos c=1 sm=1 tr=0 ts=6a670a61 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=8wly15aAkipbUTg-oLQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: rBotP_Z1oGaqq4c3vdM6rgByPQF8s5sQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA3NCBTYWx0ZWRfX7ZEdsICSGXtF
 Urx88Ma7DJyUQYFu0QzFkmd/mfY+cd6IUsDPG8r2ogT3dWdgZ6N1eoMcjtnf9QrGjCdN/tGsufU
 2faojAUf8arRz5agiFbO014pWl1gulFqYsV2JC5MQH7SQIq9sJwFvAxw85dxfX7WOvQO/E2xVrq
 OM1SaNmreOVKGg8B+hEngyPJilvHM9rTpmypYRX+HGX4AqFH+DMuoJZB8kb2a5FSekUiIF9Z5VJ
 oVKp9LRDbs0xdH05GLDTRqEnz8xFlQvJ/Ch1k9ABaFA1Gtnizmnp8dNXO0U5h5QW3EBa3XgKQh1
 avhqglLyixnsxe699AMZveElIL3mF7QJUvqTnowm4XEKdgCRUwnBPXeVSYw5etNKGP76MB3PbTf
 M7yw0OoHubJqvT/YJMPhhd6Z+e3rM+/1flSHKPfyJXHcOux0rXqGpftj+5b88zIXE1oz7mu4+cR
 G1+uPcQUXiKcMrbOgtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270074
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

On 27/7/26 06:40, Akihiko Odaki wrote:
> On 2026/07/27 6:09, Marc-André Lureau wrote:
>> On Mon, Jul 27, 2026 at 12:49 AM Michael S. Tsirkin <mst@redhat.com> 
>> wrote:
>>>
>>> On Mon, Jul 27, 2026 at 12:44:04AM +0400, Marc-André Lureau wrote:
>>>> Fixes: 680935c9a6ff ("hw/cxl: Add a performant (and correct) path 
>>>> for the non interleaved cases")
>>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>
>>> Not commit log really?
>>
>> SSIA, but I can make it longer if it helps.
> 
> I agree the subject is sufficient so:
> 
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> 
> That said, we can quote docs/devel/style.rst if desired:
> 
>  > * Variables declared with g_auto* MUST always be initialized,
>  >   otherwise the cleanup function will use uninitialized stack memory

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


