Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A816FD5307
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 07:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvsel-0003ea-Tn; Fri, 27 Feb 2026 02:53:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vvseg-0003dy-2C; Fri, 27 Feb 2026 02:52:58 -0500
Received: from 8.mo548.mail-out.ovh.net ([46.105.45.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vvsee-00009y-8q; Fri, 27 Feb 2026 02:52:57 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.172])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4fMgXz71nTz5wBX;
 Fri, 27 Feb 2026 07:52:51 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 08:52:50 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004ba2013ea-c08e-499e-991a-ad224dca7367,
 1764588C194503052958D0AAF3448E51E66CE866) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <047f2aea-acc7-4966-8b55-723709fe0f28@kaod.org>
Date: Fri, 27 Feb 2026 08:52:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 18/22] hw/i3c: Add Mock target
To: Jithu Joseph <jithu.joseph@oss.qualcomm.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, "komlodi@google.com"
 <komlodi@google.com>, Titus Rwantare <titusr@google.com>, Patrick Venture
 <venture@google.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
 <20260225021158.1586584-19-jamin_lin@aspeedtech.com>
 <c904f61d-b836-41e2-8032-31ea32324396@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <c904f61d-b836-41e2-8032-31ea32324396@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG13EX2.mxp5.local (172.16.2.132) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 9861e815-fb2c-4b34-9764-79756572d32d
X-Ovh-Tracer-Id: 5571797166078397197
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTENp50b907tC5SjI0Y0VyUj6vqapV2EZsg8yEII8HQJMQvqkowfF9OpAw9p+wCfci6Hhz6cG8j2JT/5d2yM6tKwftCFG0VW6HNWnWbUfSRzZDqV5Luo4jmkaK+i1TlcWbzpCH3Sqlr3byblk0biRAvYQUpOgZkwtO7CBAUycG+x0HYXxLXr6CaO4lqGs2PGf4CtrqS7XpOqVCErLIyGtrSMfYpjpRLhN0rFEEVGr5YwAHr8YnCPKdSWNeUqYN14+YunppqQsYGQ3KFf8MCnbjpZoOMw54aLzU4PuNsKULtpx7yoYD8SQz5OBAdsUas9SJEkmrnKT/wtpFjTQF9hBWoHPfN3BR7sB94i6pC8pKcj4TlzhDKxs+TVXktlMRAaEXD+V4yR/c/gRMBFcfwNm+x7qn7feCDnNtn/Q7mLxnRf+iczfMn4fR2JLRdHY5mmdsIwplRbAh2aGSwraFLtXb9Go06e2WgeJW/3fOyCJdNBOJcorTmnXiTzdYTRWDk3i3cZ4GIl/nLspqwc8vc+ewlt+rQe4S+hxL/ylVNoQldHfjTIs7uFw1QNCvgFkaD4xYzrhWpcjoDavb04IWyTbW6JtlqCJOUG/s3osN88eMpmaFM+u0pbDLlLwvbbUnhgkU+aN1B7ekmKc/tHQLMir1mQtLBVnvwXUcY0kEHUQpvQGA
DKIM-Signature: a=rsa-sha256; bh=9ZI05fIlRBAqxCJQyYmWUPmAjTHVCHcSFcIV/A9m+yU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1772178773; v=1;
 b=bmnGb0kybjdcCgnTxTByc/vnMLvlzG9S8jlLspVzMtmBY7I2g222YjKQrkEL1T40XJqmuv/Q
 Oiwa8PHVVJN1hIvw5M4NX2rjzlXVFDDcQadLYzQ1mJrvGrOZiTvc0XTqPF6SVXAeNNK5zArYpPH
 aKcgb9k+i7H2lAPiUWPt5LC2QGz0X/DdKQqunbRLSg4fogaoq08GkMFDubOIyUkP2nVkC6osyaJ
 tLsMHAZEDvlP52FgOqlLGheGDzuDUj2y/UiVBbmEDHQBAQFp6UuA7RfKyw8Pa0tYwaZJr8J12Ee
 2r77LsKKcmc+eyuiFkJe8cCojpXVAb1xR3WJNofMCdozQ==
Received-SPF: pass client-ip=46.105.45.231; envelope-from=clg@kaod.org;
 helo=8.mo548.mail-out.ovh.net
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.306,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.668, SPF_HELO_NONE=0.001,
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

On 2/27/26 02:43, Jithu Joseph wrote:
> 
> Apologies for chiming in this late ... I only got a chance to test this last week
> This really is a minor comment ... can be addressed subsequently

No problem. It is not merged yet and fixes are expected.


> 
> On 2/24/2026 6:12 PM, Jamin Lin wrote:
>> Adds a simple i3c device to be used for testing in lieu of a real
>> device.
>>
>> The mock target supports the following features:
>> - A buffer that users can read and write to.
>> - CCC support for commonly used CCCs when probing devices on an I3C bus.
>> - IBI sending upon receiving a user-defined byte.
>>
>> Signed-off-by: Joe Komlodi <komlodi@google.com>
>> Reviewed-by: Titus Rwantare <titusr@google.com>
>> Reviewed-by: Patrick Venture <venture@google.com>
>> Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>> ---
>>   include/hw/i3c/mock-i3c-target.h |  52 ++++++
>>   hw/i3c/mock-i3c-target.c         | 298 +++++++++++++++++++++++++++++++
>>   hw/i3c/Kconfig                   |  10 ++
>>   hw/i3c/meson.build               |   1 +
>>   hw/i3c/trace-events              |  10 ++
>>   5 files changed, 371 insertions(+)
>>   create mode 100644 include/hw/i3c/mock-i3c-target.h
>>   create mode 100644 hw/i3c/mock-i3c-target.c
>>
>> diff --git a/include/hw/i3c/mock-i3c-target.h b/include/hw/i3c/mock-i3c-target.h
>> new file mode 100644
> 
> ...
> 
>> +static int mock_i3c_target_tx(I3CTarget *i3c, const uint8_t *data,
>> +                              uint32_t num_to_send, uint32_t *num_sent)
>> +{
>> +    MockI3cTargetState *s = MOCK_I3C_TARGET(i3c);
>> +    int ret;
>> +    uint32_t to_write;
>> +
>> +    if (s->cfg.ibi_magic && num_to_send == 1 && s->cfg.ibi_magic == *data) {
>> +        mock_i3c_target_ibi_timer_start(s);
>> +        return 0;
>> +    }
>> +
>> +    /* Bounds check. */
>> +    if (num_to_send + s->p_buf > s->cfg.buf_size) {
>> +        to_write = s->cfg.buf_size - s->p_buf;
>> +        ret = -1;
>> +    } else {
>> +        to_write = num_to_send;
>> +        ret = 0;
>> +    }
>> +    for (uint32_t i = 0; i < to_write; i++) {
>> +        trace_mock_i3c_target_tx(data[i]);
>> +        s->buf[s->p_buf] = data[i];
>> +        s->p_buf++;
>> +    }
> 
> 
> num_sent is never updated prior to return, so the traces (from caller i3c_send) looked a bit confusing
> 
> <snip>
> mock_i3c_target_tx I3C mock target write 0x12
> i3c_send I3C send 0/1 bytes, ack=1   ---------------------> instead of 1/1 bytes
> mock_i3c_target_tx I3C mock target write 0x34
> i3c_send I3C send 0/1 bytes, ack=1
> </snip>
> 
> Something like below is needed
> + *num_sent = to_write
> (might also needed in the ibi magic path above)


Please send a patch.

Thanks,

C.


