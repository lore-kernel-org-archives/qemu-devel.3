Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56795FD530D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 07:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvsdF-0003BR-UY; Fri, 27 Feb 2026 02:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vvsdD-00039o-II
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 02:51:27 -0500
Received: from 10.mo552.mail-out.ovh.net ([87.98.187.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vvsdA-00006R-PV
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 02:51:27 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.198])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4fMgWB0QwBz5vpZ;
 Fri, 27 Feb 2026 07:51:18 +0000 (UTC)
Received: from kaod.org (37.59.142.95) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 08:51:08 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001c2f7af53-96bd-4eca-9362-57920968bfdd,
 1764588C194503052958D0AAF3448E51E66CE866) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <897005bf-fd67-4d78-86b4-b92c9cc0f666@kaod.org>
Date: Fri, 27 Feb 2026 08:51:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/22] hw/i3c: Add bus support
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
 <komlodi@google.com>, Patrick Venture <venture@google.com>, Titus Rwantare
 <titusr@google.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
 <20260225021158.1586584-4-jamin_lin@aspeedtech.com>
 <ad58c432-8c9e-4cd8-847a-df4bd6a45d6d@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <ad58c432-8c9e-4cd8-847a-df4bd6a45d6d@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG13EX1.mxp5.local (172.16.2.131) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 3403f357-30c3-4a4f-bc09-32d3c682b909
X-Ovh-Tracer-Id: 5545338519449144077
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEPhLDgOXVHtajEBrFDY3EhW7HnEz8UgDBe6V4t1xoHOqFDp+QFJkAAnw7VFDD9Qg9KVsYLNlD7SARyrHdNuG1XksDeihrDOylxwnnqpoIrz+Ohkz2NorujLzJT5ooiqlObdrLrqX7WE7GtXzRkAGVebDzfM4LEsKM02k2tA8mqGEfr4tDaUjSVjOScdj1D7SLbyBBzTRLePN1sUaJlnSjhNUhVshInouRRiggXWlS5ijkGiq3GXWtIV8wG2xr++RmZtSU7OsrzIq/C6t9HcXK0kQsfHLwpLBJwGD9RuqvHNhWEW2x7antutJ/lW5ptTldb7JcDTGa99Djc9v5lHMcweobIngG7GQ+0BaXJYpO3Yd1fouN53z6mIvcloj7Yl1qB+mrfDeG3pOQKwRIUpFZKtMRvCED0rDFYSY4dULa8DYwOiT9yBJzFbrjS1YTNZMOnuEwI6jizZx2Su2cE4zqrcns81KWIujoX+zenOwl5nEm6ct5UICImBMM1N37/AkO9nDFkT1EnaK0bm6FWMi05GxoGw8meP0o31515Imk6yORSclomHuaLGDUZcyktEKbzNC1FdsLCme+/y8EsBWymwWMfpPPKY3iChDu0uRVWJR+2M6mBIE8Z/CkFz5aza1OezCaDP2tyCX3IHwPW9a4D7P+ZpKTUggGQs10ElC9SuQ
DKIM-Signature: a=rsa-sha256; bh=sX6DciBFydF3v5K+DVPBlAqOUsrYPUw2HDLQLyrq06o=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1772178680; v=1;
 b=ooyubBuAa+IPhoBEttQnQG8YzRRCTOo7S9SO3zmD0IFRvlvUDjqPdc5gSinKgz+GzLJ+Lzsm
 w3JGDpZ/5oX0IYJRAcsgTCsL36wnyPWlwc1JlXWRnEhpMHZv//Oj8xCdVgj+VVUO4SwuR2b4wO+
 EeBrfsPIuDrMnC0PCYe7WQrU99/MvWruWdLbFAGVXpAb895jdLsRLsthcF9sedN6saiU1ImGOyw
 cd/ErWj3ij2HMnyo2ckq71dXWvYPeHRPE03q71yfXAnMLHUL33BpWfYbZy3ej/Mb//Y5/vCI0/B
 jA2kpRbxLXlx01lHwM6LhlZAVJauJaMGFcxONSV0n4IOA==
Received-SPF: pass client-ip=87.98.187.244; envelope-from=clg@kaod.org;
 helo=10.mo552.mail-out.ovh.net
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

Hello Jithu,

On 2/27/26 03:23, Jithu Joseph wrote:
> 
> Another minor comment which too can be addressed later
> 
> On 2/24/2026 6:12 PM, Jamin Lin wrote:
>> Adds an I3C bus and a target class.
>> The bus supports:
>> - I3C data transmission and reception
>> - CCCs (including ENTDAA)
>> - IBIs
>> - legacy I2C transactions
>>
>> General usage of the bus is similar to I2C. Users are expected to
>> initialize a bus via i3c_init_bus, and use the bus returned from the
>> init function to do transactions on the bus.
>>
>> In order to handle IBIs, the controller provides callbacks to handle
>> receiving an IBI from a target, receiving (optional) additional IBI
>> bytes from a target, and handling when a target is done with its IBI.
>>
>> Similarly, target creation is done via i3c_target_create_simple and
>> users use the provided I3CTarget to handle transactions.
>> The target has functions provided that it can use to invoke an IBI and
>> send additional bytes.
>>
>> Along with the send, recv, and event callbacks that are expected of an
>> I3C target, which are similar to I2C, there is a separate callback for
>> CCC handling.
>> This is to help encapsulate CCC handling and keep it separate from
>> target-specific read/write functionality.
>>
>> To avoid repition for required CCCs among I3C targets, there is some
>> class-level CCC handling added. The CCC is then passed to the target in
>> case it needs to handle it in some way.
>>
>> Signed-off-by: Joe Komlodi <komlodi@google.com>
>> Reviewed-by: Patrick Venture <venture@google.com>
>> Reviewed-by: Titus Rwantare <titusr@google.com>
>> Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>> ---
>>   include/hw/i3c/i3c.h | 277 ++++++++++++++++++
>>   hw/i3c/core.c        | 647 +++++++++++++++++++++++++++++++++++++++++++
>>   hw/i3c/meson.build   |   1 +
>>   hw/i3c/trace-events  |  16 ++
>>   4 files changed, 941 insertions(+)
>>   create mode 100644 include/hw/i3c/i3c.h
>>   create mode 100644 hw/i3c/core.c
>>
> 
> ...
> 
>> +
>> +int i3c_send_byte(I3CBus *bus, uint8_t data)
>> +{
>> +    /*
>> +     * Ignored, the caller can determine how many were sent based on if this was
>> +     * ACKed/NACKed.
>> +     */
>> +    uint32_t num_sent;
> 
> num_sent is uninitialized here. Even though i3c_send_byte ignores it after the call, it gets passed by pointer into i3c_send() where it is used in the trace_i3c_send() call.
> If the send callback does not write *num_sent (as is the case with mock_i3c_target_tx, refer my prev comment for patch 18/22), the trace might show garbage. Initializing it to zero might reduce the confusion

Could please send a patch ? I will queue it after this series.

Also, since you have tested this series, would mind sending
a Tested-by tag ? possibly a Reviewed-by too.

Thanks

C.




> 
>> +    return i3c_send(bus, &data, 1, &num_sent);
>> +}
>> +
>> +int i3c_send(I3CBus *bus, const uint8_t *data, uint32_t num_to_send,
>> +             uint32_t *num_sent)
>> +{
>> +    I3CTargetClass *tc;
>> +    I3CTarget *t;
>> +    I3CNode *node;
>> +    int ret = 0;
>> +
>> +    /* If this message is a broadcast and no CCC has been found, grab it. */
>> +    if (bus->broadcast && !bus->in_ccc) {
>> +        bus->ccc = *data;
>> +        bus->in_ccc = true;
>> +        /*
>> +         * We need to keep track if we're currently in ENTDAA.
>> +         * On any other CCC, the CCC is over on a RESTART or STOP, but ENTDAA
>> +         * is only over on a STOP.
>> +         */
>> +        if (bus->ccc == I3C_CCC_ENTDAA) {
>> +            bus->in_entdaa = true;
>> +        }
>> +    }
>> +
>> +    QLIST_FOREACH(node, &bus->current_devs, next) {
>> +        t = node->target;
>> +        tc = I3C_TARGET_GET_CLASS(t);
>> +        if (bus->in_ccc) {
>> +            if (!tc->handle_ccc_write) {
>> +                ret = -1;
>> +                continue;
>> +            }
>> +            ret = i3c_target_handle_ccc_write(t, data, num_to_send, num_sent);
>> +            /* Targets should only NACK on a direct CCC. */
>> +            if (ret && !CCC_IS_DIRECT(bus->ccc)) {
>> +                ret = 0;
>> +            }
>> +        } else {
>> +            if (tc->send) {
>> +                ret = ret || tc->send(t, data, num_to_send, num_sent);
>> +            } else {
>> +                ret = -1;
>> +            }
>> +        }
>> +    }
>> +
>> +    trace_i3c_send(*num_sent, num_to_send, ret == 0);
> 
> This trace might print garbage if the target send callback doesnt set it
> 
>> +
>> +    return ret ? -1 : 0;
>> +}
>> +
> 
> Thanks
> Jithu


