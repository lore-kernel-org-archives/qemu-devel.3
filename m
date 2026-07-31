Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BBEC5516D
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 08:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpilY-0006X3-EP; Fri, 31 Jul 2026 04:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpilX-0006Ws-09
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 04:38:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wpilV-0001d1-6K
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 04:38:50 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66V8Zokr3476235
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 08:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ABDS/iSM2z3ur2dcISaciA5V68ezVpBH8EIj0tIo3dc=; b=jTpG/z41eqKwy3G2
 1iSWgwy4loDZppiE4kmv8WtcUG6lDo/dLtSNNf2ZvVppxDkFb8EhKDRQ6Ovgfxp6
 Hk3VRFPSoayNw1q6/rL7sjXRubnhptGRdjCCLuaHQoguN4DASPCEfZqLfXZ2SZRH
 GC1pVM0c2VYsAiXMfbalkEmbMolQ/Pps+ca0CR+ZGbMzYa1hrRuS8Qp8eSumyzmE
 8FVIu60djf5kPO8YXyqAEUcrxIS12Zgv/757QtuqGfdu7S5buBscPvINoxYnFAfJ
 oQNIRYJZL5fIWTn0wOxg4bpVnnkY+7UFDHChXSPRU8JacHJvJ7z+cCn/xkDpKaP4
 EDOUJw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4frrb900bm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 08:38:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-930f5da3467so70449385a.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 01:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785487127; x=1786091927; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ABDS/iSM2z3ur2dcISaciA5V68ezVpBH8EIj0tIo3dc=;
 b=irNHpXT45xpdefeVeMRhf0TsGOz10fUKDZpMrLMvgppVKjZOBKoP+Up98ecNiWXNrR
 KsdPXoNsiXwbb1AZkrdqM6lisNRyroYk+xlCvrgl2oetNtOexS5yPgeDNPJ0lTwdzYde
 UlxckqSH8/2/O/StIc62xQ72ztJF6NNknoNNjXrRazI8MVStWhYqrzVM9/FSd8H+ZS8n
 4dAYS8sIuHY3KGHuZzMQSFQWizqILFETWeIJsy59XtVKlFYEGIrFK8chqbsye534CgDF
 LkCX19VwnWUN5tBGkpKMbcAKkCUBw+vzSoWM5sUELwq+RRnsAHeZ4pt34zEEQI3hRZwO
 osvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785487127; x=1786091927;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ABDS/iSM2z3ur2dcISaciA5V68ezVpBH8EIj0tIo3dc=;
 b=LpvsmWAwczymB8IR+NfWJh2JvznnrG29i3mhyQdSX1OCwZ9OFdO11N4tbAhr454dzX
 3qb0pkLwYA9rjWssIUaZBI2prQ+3aDG+lpxsMgt9u9xHrAaSuVb4BO31Le+VArks9Nor
 s2R2RXqYss38nfT0Uteez2bANRMuy0PIQ4EQp6zcWUuOe3tqjFcH4B/TWbIz6xy05uQ2
 jMIti2BMvdAHFBlkXIUeQvX3ib0t08Rig3QLj0gez13UmDr5ZcznbmAusOF7csjegtd/
 5vQziJ7iEay25DjrlVIuTXyoSosyCgO9bmkS0VOCZVQTAjpp7q/LMSBMh12VBMTTuPMx
 RVWg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnfbSVambcPWcreygcFLnuFmHTM8vjYUgR+23T+KVZ4VPEFi6HbOebWWSHeemDqRMqkySIxpO9mSIP@nongnu.org
X-Gm-Message-State: AOJu0Yw6zZcxjGIDxJaYhuCL0FL/kGdMmp9nAIh/5cFNrpJJN+tJTxAn
 s7/lm4EM8BEakxvHZygYR3O6Oat6G9+e0uGBsJrHS17wTxF3+ydDitJfr9FyA0Hg0AxLfVX5NG0
 F9eUX7EO4JoEaYuhFZCTCoPhh7Q9EhZq+Bgv7I/65PjcEx8xGYPd2XW+ACg==
X-Gm-Gg: AR+sD12UoQsWofcW6OfyG3XDEbHBad9rPEdN/nm6IJdjDf8QW9RFuPPOutOdd5Vbu78
 ml3r++TOwW6bRDdx6zEWdWsQ5hCn78aEIJbP3GkUq7g2L+ozUk59eWiQ/0H28jASvTjLeLxYmuA
 nfK5fs9/uE/pybpth/GOIngmXfGO8v1NkjeyTIvIOk5lV/zINXzvsXIdGY2IxA80Memu5VvT7w2
 pmo3/4Gt0SegtKmwF1Lmpm/myywYM/nPYnmhosDEqmUwn9QYUHUF/kMIzccaMSIyweFt1/aAdqe
 zYRP+abBmZsq2+wxrj6mMtubOGvwf20uGYCcOr2h+oQVby+VnWPUFwQJPgs8tt+U/qzGxwt0ya0
 xLLfyH23LxVWAlhsIH5/stgmwgyBklY3wroLt2IHhEZwpbRpSuqw=
X-Received: by 2002:a05:622a:1f95:b0:528:3b9b:4f50 with SMTP id
 d75a77b69052e-52b4af40e91mr12931511cf.9.1785487127103; 
 Fri, 31 Jul 2026 01:38:47 -0700 (PDT)
X-Received: by 2002:a05:622a:1f95:b0:528:3b9b:4f50 with SMTP id
 d75a77b69052e-52b4af40e91mr12931131cf.9.1785487126690; 
 Fri, 31 Jul 2026 01:38:46 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd3c5b0efsm68261066b.10.2026.07.31.01.38.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 01:38:45 -0700 (PDT)
Message-ID: <b7a8f165-1d7a-4733-b8a1-1c90448dfcbe@oss.qualcomm.com>
Date: Fri, 31 Jul 2026 10:38:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] virtio: make virtio_add_queue() queue_size an
 unsigned int
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 virtio-fs@lists.linux.dev, Hanna Reitz <hreitz@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, Alexander Graf
 <graf@amazon.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-block@nongnu.org,
 Greg Kurz <groug@kaod.org>, Raphael Norwitz <rnorwitz@nvidia.com>,
 Eric Auger <eric.auger@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Amit Shah <amit@kernel.org>
References: <20260730205846.19479-1-stefanha@redhat.com>
 <20260730205846.19479-2-stefanha@redhat.com>
 <eef9784f-5e68-4f1a-ba12-85ad4128116d@oss.qualcomm.com>
In-Reply-To: <eef9784f-5e68-4f1a-ba12-85ad4128116d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA2MSBTYWx0ZWRfXy27i/da9o4K3
 4j+n2zbZEXl1QdeGFa8HVJdJg/A1dR6TtalQGsjkxlL79ovwIJ2uNbu5UgnoNe0qYVhvL9WSC1r
 j/bkIpSmQWJfip9ZTzkP02qDUBIqzz8=
X-Proofpoint-ORIG-GUID: udAdlWKvaAisS6Si4zW8YrsWyRjQi_VN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA2MSBTYWx0ZWRfXzL4xti/pcCcT
 E2xBqe3W7wxrDP4uu1F7jVTR0QV+sjzSUx6d7lfIAbfRmF58W0x06P2UQjIemeP0lp/LQ1xVf/e
 gwPbxAr+OO7OI6FpOdFVg+eT86VisIEVtPDAyXt+blw7qNS9SLs88kiFH0nm8gDSwNjJCfEtwk6
 oOEDihmq4Z0l+6kqf+zXIno7inbPuGGAcf86fvIUEyjZei9Bn/GA59tRqTsMBxtw/rRKo2+JLbQ
 YubJfWav0aQQUglbQm8w35STOJOzjCIZYNuuzk05Ow8Moljp78DVfBJGjYuauRAqFWq47l4Yy+e
 PCMXlAuHLWjjJMWhLmydfc8buKbh2abwvLVuWovQnBfCyWQyEYhjktFd+9P+2doOiTYuDga8peQ
 da9NVui/Rkmk3BmbwTszMBLMCLlITKrNpBeHDkqNZe2ZbrwNvDKCg+2dsh7Yl8/rC5OL85nF1M5
 X/PCs3V7epRiBKwnlyQ==
X-Authority-Analysis: v=2.4 cv=c4ybhx9l c=1 sm=1 tr=0 ts=6a6c5f17 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=hTGag2EiyIdp9CllqmUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: udAdlWKvaAisS6Si4zW8YrsWyRjQi_VN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310061
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 31/7/26 10:35, Philippe Mathieu-DaudÃ© wrote:
> Hi Stefan,
> 
> On 30/7/26 22:58, Stefan Hajnoczi wrote:
>> virtio_add_queue()'s queue_size argument is a signed int. The
>> vdev->vq[i].vring.num and num_default fields are already declared as
>> unsigned int, so change the virtio_add_queue() argument's type for
>> consistency.
>>
>> A note on consistency: the VIRTIO specification defines queue size as an
>> unsigned 16-bit value.
> 
> Why not use uint16_t then?

(Otherwise size_t is more explicit for unsigned int size).

> 
>> QEMU's device models variously use uint16_t,
>> uint32_t, and other unsigned types for queue size qdev properties.
>> virtio_add_queue() limits queue size to the much smaller
>> VIRTQUEUE_MAX_SIZE (1024) constant, so the different widths don't really
>> matter.
>>
>> I have checked that all callers of virtio_add_queue() pass an unsigned
>> queue size.
>>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>   include/hw/virtio/virtio.h | 2 +-
>>   hw/virtio/virtio.c         | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)


