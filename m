Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDD8CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 16:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utTkU-0002z9-Nt; Tue, 02 Sep 2025 12:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utTkO-0002sy-1z
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:20:41 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utTkJ-0005bd-Cq
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 12:20:39 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3d0b6008a8bso2255205f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 09:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756830033; x=1757434833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=10cXgaC3C/UoQgzZR9x55zN1RCuFGwwNO0y42Z+c758=;
 b=V26zAXX9uo7VZKbeHx225BmgVeAaCECJ1VVZKfsZiYQKISQo1dFw9hcxDwFbKPpJ3N
 H0aDDRdEv151oi1gBC519lHM97yos/jWGwXcdlQKkBaAzkXoeCEQFHHlfhpZUgVYiTkt
 n92N5NfZw3cgV279F5Qfg9NVnm+0ezIpOTGDtpCZTL4EAJnOUlUotM8kEri7lpp7Iize
 GK+VR4yNpW+r7GkKPBYKFxqDuIRCgMSXAnU6HSCfghaWhxTXM784Wsv+mqQg3eI4zmZI
 +YR39WGSRKtz1kMSmnXVzL8H4MZQtBvesO1E+VGnsoEVQmaVCM6c0Yl+AxUqJcx0JYRV
 ysKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756830033; x=1757434833;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=10cXgaC3C/UoQgzZR9x55zN1RCuFGwwNO0y42Z+c758=;
 b=uEAStXZzlNQrpPRJRbLSlB67cqWBFiYmWVC4LdR0y9W1rVwcwsndyCMeiq4ABNK9DD
 rXRlca4NxWmNVrj2zYAg8a28ODXjp1SIlz+ljJOLuzWo+ZYzviSXpHxAoXVSIHP3gMXS
 25nozwxw7HLIHJpG1vZdG15O4sS46BkZzeGhWrYw71kRmA/a7y/1pbyBSKwKXa2Eiv+Q
 ZqEYsyjwAIAdesSWDJrbWT1nrbMGCAQ6sURFLFRZHYY+y7JNxm78I3mAUa1134U7vHYy
 jnOyBeIGWiotSTNrAa7J+YJB9QP5vAp50l0RC0w3vN1Z/z+aJ4/PZxxuK8SPXBMg0Nxy
 q9PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFpzdNI1JuFgRVhXB8oq0ZIUZ70gnuIabRMwIwVfXGGTNWcIQfr3KjAa5HslWWs7EmkIZvN210e4jU@nongnu.org
X-Gm-Message-State: AOJu0YzoX7HsnVednlEfIftnVja9p1w9yelUUf7oHNLSMYfJz0UO6V+R
 tJ9GpikUekc+yvnDD0CWai/D78WFTcDKUr01Nr4GmZa5dG9dkCf0zclS1XMl4Y2KThg=
X-Gm-Gg: ASbGncteWE2mRTwABRReTK6jP3DM2LaCvYkgAaY50mJIXE+eJoSR37hae7HavBMRZr5
 qcCUGMG1lCbQkfPqmUYhMT4LfY97exJxJ8Ax4cfbLKQZyfQ3o8RrC4YeoHBqChd92FRVyELcKX5
 +pJUMkR48eF2iSIYVhjfJV9N5mQZUTke5MlT6Av815Vt1MSQ1U7CX/CQ0UnC76BIpfkdPe4zPWc
 n2rtVXtER48PSy+nkfu4lU2m/iolNz3xSCAR5JFUAuBh0CSqufyXF6+HUYrIXCZveeRA8TeF2wy
 8bWeeFy/NipgBeVKw8HlqrxFIlAyxd/W2+elrCSdTxc2fkqS8/xleH8dBMuZKrvb27/vffCDebi
 ldMOLKazNC7wnnK3S/EbRieX48DJ7PiCV6M7WQ/EUoniB4PeLTPES2daSTByRkDGsdA==
X-Google-Smtp-Source: AGHT+IEisykO+n6O8mP8/UZhsFXrAEWhbvP4zgGembqw05bwbly8nirGqt/qy/8xZqgGnTeLfV+TPg==
X-Received: by 2002:a05:6000:2285:b0:3d9:3d95:b94d with SMTP id
 ffacd0b85a97d-3d93d95bccfmr3139705f8f.6.1756830028280; 
 Tue, 02 Sep 2025 09:20:28 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34494776sm20082461f8f.61.2025.09.02.09.20.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 09:20:27 -0700 (PDT)
Message-ID: <d21f6449-e646-42fc-8277-b011a886e9c9@linaro.org>
Date: Tue, 2 Sep 2025 18:20:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/sd/sdcard: Fix size check for backing block
 image
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?SmFuIEzDvGJiZSI=?= <jlu@pengutronix.de>,
 Joel Stanley <joel@jms.id.au>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair@alistair23.me>,
 Alexander Bulekov <alxndr@bu.edu>
References: <cover.1756706188.git.jan.kiszka@siemens.com>
 <86217712232abd5152e7dfa98111f57b9b78d83b.1756706188.git.jan.kiszka@siemens.com>
 <6289fe04-82be-4a34-9fed-b0cc08e3b8f0@linaro.org>
 <a9fdf524-0ca1-45db-be39-7bfccc468f0f@siemens.com>
 <11808e86-cee0-48bf-8fbd-de13a9a25ed0@linaro.org>
 <4c039b3c-dc2c-4478-b1bb-90b925e56245@linaro.org>
 <c8e1a073-7702-4bad-b7f1-2b4f51da47f4@kaod.org>
 <03a51e36-9a15-4b49-a310-c36a4d0af360@linaro.org>
 <2abbaeda-f9dc-4045-a9f7-b2b48451255f@kaod.org>
 <42310bdb-4fad-4df2-b7ad-3ff3f863e248@linaro.org>
Content-Language: en-US
In-Reply-To: <42310bdb-4fad-4df2-b7ad-3ff3f863e248@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/9/25 18:14, Philippe Mathieu-Daudé wrote:
> On 2/9/25 18:00, Cédric Le Goater wrote:
>> On 9/2/25 17:55, Philippe Mathieu-Daudé wrote:
>>> On 2/9/25 17:47, Cédric Le Goater wrote:
>>>> On 9/2/25 17:45, Philippe Mathieu-Daudé wrote:
>>>>> On 2/9/25 17:43, Philippe Mathieu-Daudé wrote:
>>>>>> On 2/9/25 17:34, Jan Kiszka wrote:
>>>>>>> On 02.09.25 17:06, Philippe Mathieu-Daudé wrote:
>>>>>>>> On 1/9/25 07:56, Jan Kiszka wrote:
>>>>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>>
>>>>>>>>> The power-of-2 rule applies to the user data area, not the 
>>>>>>>>> complete
>>>>>>>>> block image. The latter can be concatenation of boot partition 
>>>>>>>>> images
>>>>>>>>> and the user data.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>>>> ---
>>>>>>>>>    hw/sd/sd.c | 2 +-
>>>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>>>>>>>> index 8c290595f0..16aee210b4 100644
>>>>>>>>> --- a/hw/sd/sd.c
>>>>>>>>> +++ b/hw/sd/sd.c
>>>>>>>>> @@ -2789,7 +2789,7 @@ static void sd_realize(DeviceState *dev, 
>>>>>>>>> Error
>>>>>>>>> **errp)
>>>>>>>>>                return;
>>>>>>>>>            }
>>>>>>>>>    -        blk_size = blk_getlength(sd->blk);
>>>>>>>>> +        blk_size = blk_getlength(sd->blk) - sd->boot_part_size 
>>>>>>>>> * 2;
>>>>>>>>>            if (blk_size > 0 && !is_power_of_2(blk_size)) {
>>>>>>>>>                int64_t blk_size_aligned = pow2ceil(blk_size);
>>>>>>>>>                char *blk_size_str;
>>>>>>>>
>>>>>>>> This seems to break the tests/functional/arm/test_aspeed_rainier.py
>>>>>>>> test due to mmc-p10bmc-20240617.qcow2 size:
>>>>>>>>
>>>>>>>> Command: /builds/qemu-project/qemu/build/qemu-system-arm - 
>>>>>>>> display none -
>>>>>>>> vga none -chardev socket,id=mon,fd=5 -mon 
>>>>>>>> chardev=mon,mode=control -
>>>>>>>> machine rainier-bmc -chardev socket,id=console,fd=10 -serial
>>>>>>>> chardev:console -drive file=/builds/qemu-project/qemu/ 
>>>>>>>> functional- cache/
>>>>>>>> download/
>>>>>>>> d523fb478d2b84d5adc5658d08502bc64b1486955683814f89c6137518acd90b,if=sd,id=sd2,index=2 -net nic -net user -snapshot
>>>>>>>> Output: qemu-system-arm: Invalid SD card size: 16 GiB
>>>>>>>> SD card size has to be a power of 2, e.g. 16 GiB.
>>>>>>>>
>>>>>>>> https://gitlab.com/qemu-project/qemu/-/jobs/11217561316
>>>>>>>>
>>>>>>>
>>>>>>> Hmm, then the test was always wrong as well. I suspect the aspeed is
>>>>>>> enabling boot partitions by default, and the image was created to 
>>>>>>> pass
>>>>>>> the wrong alignment check. Where / by whom is the image maintained?
>>>>>>
>>>>>> Cédric Le Goater (Cc'ed).
>>>>>>
>>>>>> The test comes from:
>>>>>> https://lore.kernel.org/qemu-devel/4d1777d6-0195-4ecb- 
>>>>>> a85f-09964268533d@kaod.org/
>>>>>>
>>>>>> Maybe also relevant to your suspicion:
>>>>>> https://lore.kernel.org/qemu-devel/e401d119-402e-0edd- 
>>>>>> c2bf-28950ba48ccb@kaod.org/
> 
> [*]
> 
>>>>>
>>>>> Digging further:
>>>>> https://lore.kernel.org/qemu- 
>>>>> devel/9046a4327336d4425f1e7e7a973edef9e9948e80.camel@pengutronix.de/
>>>>>
>>>>
>>>> yes commit c078298301a8 might have some impact there.
>>>
>>> With Jan patch, your script doesn't need anymore the
>>>
>>>    echo "Fixing size to keep qemu happy..."
>>>
>>> kludge.
>>
>> which script ?
> 
> The one you pasted in [*]:
> 
> -- 
> #!/bin/sh
> 
> URLBASE=https://jenkins.openbmc.org/view/latest/job/latest-master/ 
> label=docker-builder,target=witherspoon-tacoma/lastSuccessfulBuild/ 
> artifact/openbmc/build/tmp/deploy/images/witherspoon-tacoma/
> 
> IMAGESIZE=128
> OUTFILE=mmc.img
> 
> FILES="u-boot.bin u-boot-spl.bin obmc-phosphor-image-witherspoon- 
> tacoma.wic.xz"
> 
> for file in ${FILES}; do
> 
>      if test -f ${file}; then
>          echo "${file}: Already downloaded"
>      else
>          echo "${file}: Downloading"
>          wget -nv ${URLBASE}/${file}
>      fi
> done
> 
> echo
> 
> echo "Creating empty image..."
> dd status=none if=/dev/zero of=${OUTFILE} bs=1M count=${IMAGESIZE}
> echo "Adding SPL..."
> dd status=none if=u-boot-spl.bin of=${OUTFILE} conv=notrunc
> echo "Adding u-boot..."
> dd status=none if=u-boot.bin of=${OUTFILE} conv=notrunc bs=1K seek=64
> echo "Adding userdata..."
> unxz -c obmc-phosphor-image-witherspoon-tacoma.wic.xz | dd 
> status=progress of=${OUTFILE} conv=notrunc bs=1M seek=2
> echo "Fixing size to keep qemu happy..."
> truncate --size 16G ${OUTFILE}
> 
> echo "Done!"
> echo
> echo " qemu-system-arm -M tacoma-bmc -nographic -drive 
> file=mmc.img,if=sd,index=2,format=raw"
> ---

FTR the alignment check was added to shut up fuzzed CVEs in commit
a9bcedd15a5 ("hw/sd/sdcard: Do not allow invalid SD card sizes"):

     QEMU allows to create SD card with unrealistic sizes. This could
     work, but some guests (at least Linux) consider sizes that are not
     a power of 2 as a firmware bug and fix the card size to the next
     power of 2.

     While the possibility to use small SD card images has been seen as
     a feature, it became a bug with CVE-2020-13253, where the guest is
     able to do OOB read/write accesses past the image size end.

     In a pair of commits we will fix CVE-2020-13253 as:

         Read command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
         occurred and no data transfer is performed.

         Write command is rejected if BLOCK_LEN_ERROR or ADDRESS_ERROR
         occurred and no data transfer is performed.

         WP_VIOLATION errors are not modified: the error bit is set, we
         stay in receive-data state, wait for a stop command. All further
         data transfer is ignored. See the check on sd->card_status at
         the beginning of sd_read_data() and sd_write_data().

     While this is the correct behavior, in case QEMU create smaller SD
     cards, guests still try to access past the image size end, and QEMU
     considers this is an invalid address, thus "all further data
     transfer is ignored". This is wrong and make the guest looping until
     eventually timeouts.

     Fix by not allowing invalid SD card sizes (suggesting the expected
     size as a hint):

       $ qemu-system-arm -M orangepi-pc -drive 
file=rootfs.ext2,if=sd,format=raw
       qemu-system-arm: Invalid SD card size: 60 MiB
       SD card size has to be a power of 2, e.g. 64 MiB.
       You can resize disk images with 'qemu-img resize <imagefile> 
<new-size>'
       (note that this will lose data if you make the image smaller than 
it currently is).


I expect us to be safe and able to deal with non-pow2 regions if we use
QEMUSGList from the "system/dma.h" API. But this is a rework nobody had
time to do so far.

Regards,

Phil.

