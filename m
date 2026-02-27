Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F08CFD9E3A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 19:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw3q1-0006tM-7h; Fri, 27 Feb 2026 14:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vw3pz-0006sZ-07
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:49:23 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1vw3px-00069V-E5
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 14:49:22 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61RIm5h03733232
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 19:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6K9sfSR2fIEkQwYqHVZ/5+9B6OUMNvks+hlGXi/67i8=; b=Z/XF0LGIxnk4XX3a
 X5KL4eed1shr3gdKRk/4QG2MPqS3gfqk1Aa1NEEyw3UYgzxzCltrQUC5vll66/dW
 9H+YKVscTEuUareVKWhCHRh0nZi5tbimu516t/7yyNo7b/aKgr1UgmE8O9V267vP
 iupfT808899I24UAtX7TANjcb2J7I0tbvia+2Dl8ys8wNsrpfgXdQCE3Z66Tx6gn
 w5PWgYnfzg25CEOPNFdScOoppgQw/7j9/UFxhtTLTs5ev25p4bbbp11jL1efR7o6
 k+AMf/isrFrK9cDhI2BTzmXfiVvIqUW8/zGUdC4CxAwIsGEbeoC6EynIv2Jic1jt
 YpU1RQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ckgv50642-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 19:49:19 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2bdbe1bd565so2629228eec.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 11:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1772221758; x=1772826558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6K9sfSR2fIEkQwYqHVZ/5+9B6OUMNvks+hlGXi/67i8=;
 b=IG945+4UV46haHsFh6/rxhxqW1KD3R9G7a/ODtuvuMWxbj7Gk9R17k4Y9RYHv23gSn
 fMT8D2Z3au5SKY+n3X+dTdTCVDDTnDKnfuzNAN0GvD1U70zWFGDCyYKdk2fC/GYTi3CR
 xmaPbqLM6p0l9mMQhymw7a/y2mGJhnyfC8bYWzoLT3Mucyuz74LQITC6LVNRRHITyOsc
 rCWREmZ4VdnLkLlBZsfeNOdB6ToJcgXHwtJU9C90P4518eoR3LW95IiINe6ehers2UQ+
 l5U7QWcKbXshdBdEDt3CCvgTzCOt7c9/RvGMno/EkO/kPpcLf2H8zVzKPqF9fgar57ia
 D0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772221758; x=1772826558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6K9sfSR2fIEkQwYqHVZ/5+9B6OUMNvks+hlGXi/67i8=;
 b=OcK2glXQLgqXZslECt4TvH+fCPPb8uF7OtmDncN1IDmJ8MJgqQTFhc+OdGZOCz3ZXn
 wnI5aFAiXN2Z9p7V/xs+rXknActFI57+qDKb/DwbpSHwWeVWkSvpld4ROw9YjY7/WKIB
 t2hjNWOnqH9tQuLLsJJZDyHBjom3GBS/A0a9Vx6o4pxfct48EjBcdfRBpntxHjqkFZkP
 ZMYn8xpMyex9XIYRF1+JZGhALd7JmDxWSf0y8fzO9wbqulrZNRxIjvhXCfO4h4zyx9UI
 lq1Ua3gGiFeO92G6GfYkpeuCtcTrK97XckDDUeXLkw60WTpjFWNAsV5qR6tP3jDJtxlM
 mFoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbp0+YhaFsmD3B/fwbLvrIQ9HhymD6i2uULtn21XxNRhBvLN/l/RMcV8Zlk/BDZt4R4npMnaaLR5qW@nongnu.org
X-Gm-Message-State: AOJu0Yy7z2D0YiUiGXO5elDGLB0WjxpLgI2TnBANGcloGrJuwubdrJTJ
 8tWu5mp3+O3f+L1wRhkvpOeZ2hwO5blTYPPP+ZfZBb8smr2YvIo5xQVipmoe8iMfgWZAP4fy3AE
 dACYxE78kuHwy4Zvoow/pTy/kJq880LkxOoW+oMzIPhMpZtsekqb7Bru7ZA==
X-Gm-Gg: ATEYQzxKRYZd0bhuFa95MpJpdAznq2YqaK+RGMisVNf5a5D5g21WPlXXIvaGTccxe0s
 wQIr3PduEDh8auXITWbZIrfcPVWpX2vEddEnc0Um8mVfBmoFdaUk9V0oYnxomW5Fxn5WVyP9snB
 JPnQE+56l7HNZRHaZURozRR07JaWp/wu/bXXfuJZrFj4MbCK0DuVFFmlri9GijNyKKklBNDnzua
 TNev56A0mTgptPZ8KE0LjehN9BZHVsFKBG2EzW+jz3anXPNq6P3JcNpmqkI+rrAvBlTTTfUDkqf
 2bMa/e6tCHdNZvtThuJnkSJlXoHytXsfJ/uH7ED4WkT793B/HP4lT5t0eEX4+oX320g0L7bjWfZ
 iP6ldU7xqO3ZmfQs7pfRkZsYJkJzQuPfzKboUg1wdr+l/HBavw4FCl74zSY4JnYkCTReJejMuS8
 IqzA==
X-Received: by 2002:a05:693c:60cd:b0:2bd:ef4a:1772 with SMTP id
 5a478bee46e88-2bdef4a1b9bmr417433eec.33.1772221758434; 
 Fri, 27 Feb 2026 11:49:18 -0800 (PST)
X-Received: by 2002:a05:693c:60cd:b0:2bd:ef4a:1772 with SMTP id
 5a478bee46e88-2bdef4a1b9bmr417422eec.33.1772221757883; 
 Fri, 27 Feb 2026 11:49:17 -0800 (PST)
Received: from [10.110.80.16] (i-global254.qualcomm.com. [199.106.103.254])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdf0cd07e6sm307371eec.21.2026.02.27.11.49.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 11:49:17 -0800 (PST)
Message-ID: <734cf0d5-6f0a-4f13-a2e0-e35fa0f47997@oss.qualcomm.com>
Date: Fri, 27 Feb 2026 11:49:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 18/22] hw/i3c: Add Mock target
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>,
 "komlodi@google.com" <komlodi@google.com>, Titus Rwantare
 <titusr@google.com>, Patrick Venture <venture@google.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
 <20260225021158.1586584-19-jamin_lin@aspeedtech.com>
 <c904f61d-b836-41e2-8032-31ea32324396@oss.qualcomm.com>
 <047f2aea-acc7-4966-8b55-723709fe0f28@kaod.org>
Content-Language: en-US
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
In-Reply-To: <047f2aea-acc7-4966-8b55-723709fe0f28@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE3NCBTYWx0ZWRfX2P59xzecAi+j
 PRtYJuZMj9rSLEZwu6fW8IiNV7uCSsjLSMdOC9tBfMO+saj9UtbG09VmqUmP/2IgPxNIJnv2wc9
 iE3d3YkMUf+HnUOjLNw0ADEtiyyILmyc+nmRykRDlGL+KhaD1RCIjmwYHA3Ysz474W+PmdksRcU
 wOs8sg0yP9V9TDBd3jBD6tQaBbCdg237ZmLp3rP1psKeljxFFMos2IkJKaMwaD29HD20FSRHrDO
 9S0RBW0Ibi0kFUen4muiQeKilonYsmIbKt/mZ+habkZnqIxV3miQDkk1RwWaI5DLqrtQeDG2641
 qhFIs09Bpdk49RXzrJh57/F397qtTP/IIYIQ7OejuPAU6Gb3UkE99YGD3RDl+Kcp6Oblr/rf86V
 xw9Ny6glc6dYTkwkGw1t6e7m7HNdIP0U+wGbdfZXe7rFxEFgDI++7wonFmyyuX6WLhpyc5JNqOU
 G1tIPSMHigBGgk9oOag==
X-Proofpoint-GUID: 6UdygRYW48NJfjHEAzlvFT8RYWMvYcWv
X-Proofpoint-ORIG-GUID: 6UdygRYW48NJfjHEAzlvFT8RYWMvYcWv
X-Authority-Analysis: v=2.4 cv=Z8Hh3XRA c=1 sm=1 tr=0 ts=69a1f53f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=0OfGDMpDe1E0IF_93y4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602270174
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/26/2026 11:52 PM, Cédric Le Goater wrote:
> On 2/27/26 02:43, Jithu Joseph wrote:
>>
>> Apologies for chiming in this late ... I only got a chance to test this last week
>> This really is a minor comment ... can be addressed subsequently
> 
> No problem. It is not merged yet and fixes are expected.
> 

...

>>> +static int mock_i3c_target_tx(I3CTarget *i3c, const uint8_t *data,
>>> +                              uint32_t num_to_send, uint32_t *num_sent)
>>> +{
>>> +    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
>>> +    int ret;
>>> +    uint32_t to_write;
>>> +
>>> +    if (s->cfg.ibi_magic && num_to_send == 1 && s->cfg.ibi_magic == *data) {
>>> +        mock_i3c_target_ibi_timer_start(s);
>>> +        return 0;
>>> +    }
>>> +
>>> +    /* Bounds check. */
>>> +    if (num_to_send + s->p_buf > s->cfg.buf_size) {
>>> +        to_write = s->cfg.buf_size - s->p_buf;
>>> +        ret = -1;
>>> +    } else {
>>> +        to_write = num_to_send;
>>> +        ret = 0;
>>> +    }
>>> +    for (uint32_t i = 0; i < to_write; i++) {
>>> +        trace_mock_i3c_target_tx(data[i]);
>>> +        s->buf[s->p_buf] = data[i];
>>> +        s->p_buf++;
>>> +    }
>>
>>
>> num_sent is never updated prior to return, so the traces (from caller i3c_send) looked a bit confusing
>>
>> <snip>
>> mock_i3c_target_tx I3C mock target write 0x12
>> i3c_send I3C send 0/1 bytes, ack=1   ---------------------> instead of 1/1 bytes
>> mock_i3c_target_tx I3C mock target write 0x34
>> i3c_send I3C send 0/1 bytes, ack=1
>> </snip>
>>
>> Something like below is needed
>> + *num_sent = to_write
>> (might also needed in the ibi magic path above)
> 
> 
> Please send a patch.

Would you like me to revise this patch with the changes, and send it in-reply-to v7 18/22 ?

or would you like me to first apply the whole series and create a new patch with just the delta suggested above ?


Jithu


