Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21264C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 09:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3Ap0-0006m1-DZ; Fri, 11 Apr 2025 05:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=05Ho=W5=kaod.org=clg@ozlabs.org>)
 id 1u3Aos-0006cb-S3; Fri, 11 Apr 2025 05:37:07 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=05Ho=W5=kaod.org=clg@ozlabs.org>)
 id 1u3Aop-0007rv-RI; Fri, 11 Apr 2025 05:37:06 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZYs5f3qMPz4xND;
 Fri, 11 Apr 2025 19:36:54 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZYs5Y1fw2z4x3S;
 Fri, 11 Apr 2025 19:36:48 +1000 (AEST)
Message-ID: <504d1ba6-7484-448f-9fed-e0eb999d80d1@kaod.org>
Date: Fri, 11 Apr 2025 11:36:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Configuring onboard devices, in particular memory contents
To: Kane Chen <kane_chen@aspeedtech.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>
References: <20250402091447.3381734-1-kane_chen@aspeedtech.com>
 <9171629d-a386-4971-802b-cd26cc42e194@kaod.org>
 <99497c16-cee4-4098-9971-f61ef7174412@linaro.org>
 <c193e64d-6ce7-4e5c-bb2a-3e1d3f4f143e@kaod.org>
 <SI6PR06MB7631DDEA18B197B4C343386DF7AA2@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <254844fd-15b8-47b2-9203-b19f8279c757@kaod.org>
 <877c3ulw6e.fsf_-_@pond.sub.org>
 <SI6PR06MB7631F15BE074BDD006B8935BF7B62@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI6PR06MB7631F15BE074BDD006B8935BF7B62@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=05Ho=W5=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/11/25 11:08, Kane Chen wrote:
> Hi Markus,
> 
> Thank you for the background information.
> 
> Since the OTP device is part of the Secure Boot Controller (SBC), I plan to register it in the global table. I believe this will simplify usage.
> 
> Meanwhile, based on Philippe's comment, I’m working on `aspeed_otp.c` to handle low-level OTP operations. 
>
> This approach should help decouple SBC and OTP functionalities.

AFAUI, I think Philippe meant something more like a generic OPT block
model, hw/block/otp.c, which would implement the low level storage
primitives of an OTP device. This model would then be used by the
Aspeed SBC model, providing the SW/HW interface, and possibly also
used by other models, such as the NPCM7xxOTPState, BCM2835OTPState,
and SiFiveUOTPState models.

Anyhow, separating the layers is a good idea :
   - OTP like device
   - Aspeed SBC interface
   - machine/SoC interface to define the backend.
   - and a doc update !
   - possibly a (functional) test case


Thanks,

C.



> 
> Once testing is complete, I will submit a separate patch for further review.
> 
> Best regards,
> Kane
>> -----Original Message-----
>> From: Markus Armbruster <armbru@redhat.com>
>> Sent: Tuesday, April 8, 2025 7:39 PM
>> To: Cédric Le Goater <clg@kaod.org>
>> Cc: Kane Chen <kane_chen@aspeedtech.com>; Philippe Mathieu-Daudé
>> <philmd@linaro.org>; Peter Maydell <peter.maydell@linaro.org>; Steven Lee
>> <steven_lee@aspeedtech.com>; Troy Lee <leetroy@gmail.com>; Jamin Lin
>> <jamin_lin@aspeedtech.com>; Andrew Jeffery
>> <andrew@codeconstruct.com.au>; Joel Stanley <joel@jms.id.au>; open
>> list:ASPEED BMCs <qemu-arm@nongnu.org>; open list:All patches CC here
>> <qemu-devel@nongnu.org>; qemu-block <qemu-block@nongnu.org>; Troy Lee
>> <troy_lee@aspeedtech.com>
>> Subject: Configuring onboard devices, in particular memory contents (was:
>> [PATCH v1 0/1] hw/misc/aspeed_sbc: Implement OTP memory and controller)
>>
>> Cédric Le Goater <clg@kaod.org> writes:
>>
>>> Hello Kane,
>>>
>>> + Markus (for ebc29e1beab0 implementation)
>>>
>>> On 4/7/25 09:33, Kane Chen wrote:
>>>> Hi Cédric/Philippe,
>>>> OTP (One-Time Programmable) memory is a type of non-volatile memory
>>>> in which each bit can be programmed only once. It is typically used
>>>> to store critical and permanent information, such as the chip ID and
>>>> secure boot keys. The structure and behavior of OTP memory are
>>>> consistent across both the AST1030 and AST2600 platforms.
>>>> As Philippe pointed out, this proposal models the OTP memory as a
>>>> flash device and utilizes a block backend for persistent storage. In
>>>> contrast, existing implementations such as NPCM7xxOTPState,
>>>> BCM2835OTPState, and SiFiveUOTPState expose OTP memory via MMIO
>> and
>>>> always initialize it in a blank state.
>>>
>>> AFAIU, Aspeed SBC is also MMIO based or is there another device, an
>>> eeprom, accessible through an external bus ? How is it implemented in
>>> HW ?
>>>
>>>> The goal of this design is to
>>>> allow the guest system to boot with a pre-configured OTP memory
>>>> state.
>>>
>>> Yes. This is a valid request. It's not the first time we've had this
>>> kind of requests. The initial content of EEPROM devices are an example
>>> and some machines, like the rainier, have a lot.
>>>
>>> If the device can be defined on the command line, like would be an
>>> EEPROM device attached to an I2C bus or a flash device attached to a
>>> SPI bus, we can use a 'drive' property. Something like :
>>>
>>>    qemu-system-arm -M ast2600-evb \
>>>        -blockdev node-name=fmc0,driver=file,filename=/path/to/fmc0.img
>> \
>>>        -device mx66u51235f,bus=ssi.0,cs=0x0,drive=fmc0 \
>>>        -blockdev node-name=fmc1,driver=file,filename=/path/to/fmc1.img
>> \
>>>        -device mx66u51235f,bus=ssi.0,cs=0x1,drive=fmc1 \
>>>        -blockdev node-name=spi1,driver=file,filename=/path/to/spi1.img \
>>>        -device mx66u51235f,cs=0x0,bus=ssi.1,drive=spi1 \
>>>        ...
>>>
>>> However, the Aspeed SBC device is a platform device and it makes
>>> things more complex : it can not be created on the command line, it is
>>> directly created by the machine and the soc and passing device
>>> properties to specify a blockdev it is not possible :
>>>
>>>    qemu-system-arm -M ast2600-evb \
>>>        -blockdev
>> node-name=otpmem,driver=file,filename=/path/to/otpmem.img \
>>>        -device aspeed-sbc,drive=otpmem \
>>>        ...
>>
>> Configuring onboard devices is an old problem, and so far we have failed at
>> solving it adequately.
>>
>> -device / device_add let you configure the new device in a general way, but
>> these work only for device the user creates, not for devices the board creates
>> automatically.
>>
>> We have a bunch of ad hoc and mostly ancient ways to configure them, but
>> they're all limited.  For example:
>>
>> * A number of old command line options, such as -drive, -serial, -net
>>    nic, create device backends and additionally deposit configuration in
>>    some global table the board may elect to use however it sees fit.  The
>>    intended use is to create frontends connected to these backends.
>>
>>    Some boards error out when they can't honor something in the table.
>>    Others silently ignore parts of the table, or all of it.  Bad UI.
>>
>>    Device configuration the table doesn't support is not accessible this
>>    way.  If you extend the table (and the associated option) to provide
>>    access to some device-specific configuration, all the other devices
>>    will silently ignore the new configuration bits.  Again, bad UI.
>>
>>    There's another serious issue with block devices: -drive is obsolete
>>    for configurating complex block backends.  But its replacement
>>    -blockdev is for backend configuration only.  If you use -blockdev,
>>    you can't add to the table.
>>
>> * Command line option -global lets you change property defaults.  This
>>    can be used to configure an onboard device as long as it is the only
>>    such device in the system.  Limited use, and also bad UI.
>>
>> A modern attempt at a solution is to have machine properties alias properties
>> of onboard devices, so you can specify them with -machine.
>> For instance, a few machines expose the "drive" property of two onboard
>> pflash devices as machine properties "pflash0" and "pflash1".
>>
>> Commits
>>
>>      e0561e60f170 (hw/arm/virt: Support firmware configuration with
>> -blockdev)
>>      ebc29e1beab0 (pc: Support firmware configuration with -blockdev)
>>
>> explain this in a lot more detail in their commit messages.
>>
>> Sadly, this solution does not scale.  Adding alias properties to the machine
>> object is work, sometimes a lot of work (evidence: the two commits above).
>> There are simply too many onboard devices with too many properties to all
>> manually alias.
>>
>> Of course, even an insufficiently general / scalable solution like this one can
>> work well enough for specific cases.
>>
>>>> To support this, the OTP memory is backed by a file, simulating
>>>> persistent flash behavior.
>>>
>>> The idea is good but the implementation is problematic.
>>>
>>>      +static BlockBackend *init_otpmem(int64_t size_bytes)
>>>      +{
>>>      +    Error *local_err = NULL;
>>>      +    BlockDriverState *bs = NULL;
>>>      +    BlockBackend *blk = NULL;
>>>      +    bool image_created = false;
>>>      +    QDict *options;
>>>      +    uint32_t i, odd_def = 0xffffffff, even_def = 0, *def;
>>>      +
>>>      +    if (!g_file_test(OTP_FILE_PATH, G_FILE_TEST_EXISTS)) {
>>>      +        bdrv_img_create(OTP_FILE_PATH, "raw", NULL, NULL,
>>>      +                        NULL, size_bytes, 0, true, &local_err);
>>>      +        if (local_err) {
>>>      +            qemu_log_mask(LOG_GUEST_ERROR,
>>>      +                          "%s: Failed to create image %s: %s\n",
>>>      +                          __func__, OTP_FILE_PATH,
>>>      +                          error_get_pretty(local_err));
>>>      +            error_free(local_err);
>>>      +            return NULL;
>>>      +        }
>>>      +        image_created = true;
>>>      +    }
>>>      +
>>>      +    blk = blk_new(qemu_get_aio_context(),
>>>      +                  BLK_PERM_CONSISTENT_READ |
>> BLK_PERM_WRITE,
>>>      +                  0);
>>>      +    if (!blk) {
>>>      +        qemu_log_mask(LOG_GUEST_ERROR,
>>>      +                      "%s: Failed to create BlockBackend\n",
>>>      +                      __func__);
>>>      +        return NULL;
>>>      +    }
>>>      +
>>>      +    options =  qdict_new();
>>>      +    qdict_put_str(options, "driver", "raw");
>>>      +    bs = bdrv_open(OTP_FILE_PATH, NULL, options, BDRV_O_RDWR,
>> &local_err);
>>>      +    if (local_err) {
>>>      +        qemu_log_mask(LOG_GUEST_ERROR,
>>>      +                      "%s: Failed to create OTP memory, err =
>> %s\n",
>>>      +                      __func__, error_get_pretty(local_err));
>>>      +        blk_unref(blk);
>>>      +        error_free(local_err);
>>>      +        return NULL;
>>>      +    }
>>>      +
>>>      +    blk_insert_bs(blk, bs, &local_err);
>>>      +    if (local_err) {
>>>      +        qemu_log_mask(LOG_GUEST_ERROR,
>>>      +                      "%s: Failed to insert OTP memory to SBC,
>> err = %s\n",
>>>      +                      __func__, error_get_pretty(local_err));
>>>      +        bdrv_unref(bs);
>>>      +        blk_unref(blk);
>>>      +        error_free(local_err);
>>>      +        return NULL;
>>>      +    }
>>>      +    bdrv_unref(bs);
>>>      ...
>>>
>>> IMO, this is low level block code that a device model shouldn't have
>>> to deal with. A 'drive' should be used instead. Now, if the qemu-block
>>> maintainers are OK with it, we need their approval.
>>
>> Using block backends to specify the contents of a memory device is a bit of a
>> hack.  However, it's the hacky solution we use, and until we have a better
>> solution, new code is well advised to stick to the same hacky solution we use in
>> existing code.
>>
>> Why is it a bit of a hack?  Well, memory isn't a block device.  For read-only
>> memory, all we want from the block device is slurping in some image in its
>> entirety.  We're not interesting in reading parts, or writing at all.  For
>> writable memory, we are interested in writing, but there's often a awkward
>> translation to block device blocks.
>>
>>>   > The OTP memory access flow is as follows:
>>>> 1. The guest issues a read or write OTP command to the Secure Boot
>>>>      Controller (SBC)
>>>> 2. The SBC triggers the corresponding operation in the OTP controller
>>>> 3. The SBC returns the result to the guest Since the guest interacts
>>>> with OTP memory exclusively through the SBC, the OTP logic is
>>>> implemented within aspeed_sbc.c.
>>>> If there are existing architectural guidelines or design patterns
>>>> that should be followed for modeling OTP devices, I would greatly
>>>> appreciate your feedback. I am happy to revise the implementation
>>>> accordingly and submit updated patches for further review.
>>>
>>> Adding a 'drive' property to the aspeed-sbc model shouldn't change too
>>> much the proposal and it will remove the init_otpmem() routine, which
>>> is problematic.
>>>
>>> Then, we need to find a way to set the 'drive' property of the
>>> aspeed-sbc model. I suggest using the same method of the edk2 flash
>>> devices of the q35 machine. See ebc29e1beab0. Setting a machine option
>>> would set the drive. Something like :
>>>
>>>    qemu-system-arm -M ast2600-evb,otpmem=otpmem-drive \
>>>        -blockdev
>> node-name=otpmem,driver=file,filename=/path/to/otpmem.img \
>>>        ...
>>>
>>> This machine option would only be defined for machine types needing
>>> it.
>>
>> I don't love this solution, but it's what we use elsewhere.  I think Cédric is
>> right.
> 


