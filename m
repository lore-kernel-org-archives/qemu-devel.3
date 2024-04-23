Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C0EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHk0-000337-5Q; Tue, 23 Apr 2024 11:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rzHjz-00032v-AU
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:07:27 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rzHjw-0007fe-Ni
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:07:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1713884838; x=1714489638; i=deller@gmx.de;
 bh=4hW/yZ4eYGm7I+PUVfxMCl+b8FqGMm7/DKiUm2JKGVU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=NHlG8FLfOSP2eNU82Kn+gbFVud6+wxbK+8eFkNbGNwQ2ahyqqAabJLyhR64HxC4T
 6v16H9Y9f6d2E/P5x4hcO5jgRAC45nKVBq0Vw5Mu8EzlyjgOaWDZUaiJyC4Ypcneu
 ZQp+bs5C5ndZfX+n7Oq2wvGHIiudSFyNa9kfbzgQBhD81nQCifU638tc1mXSWkzTp
 MwDf2vbhWRRGPD2AWpG5zeWBOW4NAQNUpG8wP7PM5KWMutHtf+XoNobr78JQgku++
 zznFxK+txGklxCqioothzJbrsZdjcZ4lM7RBKENTfa+mP5imEcUcP4UuqSox95O0Q
 981/n9RdGcSy5paRNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzSu-1sMJsA1vlU-00PPR0; Tue, 23
 Apr 2024 17:07:18 +0200
Message-ID: <96f04d1a-2470-4118-8e07-b864f58f241e@gmx.de>
Date: Tue, 23 Apr 2024 17:07:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hppa-firmware.img missing build-id
To: Cole Robinson <crobinso@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Richard W.M. Jones"
 <rjones@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
References: <6c469c05-1bc5-4fd8-89f1-130f5aba5ff8@redhat.com>
 <d0e87002-ee5e-4a80-b850-1660bc5f2c80@redhat.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <d0e87002-ee5e-4a80-b850-1660bc5f2c80@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rfVVtq35H1pm7ebqmmecbLPN4XBkq0oF9q7Fjv1169fjF+DU5V1
 iYC9Q+Dpv571XMs79CNdgd0+7i7VcZIkVx1svrFRXvqJfUhHCXHbVvnUX3c0kHglxCgkQiH
 hvxNLdc2WD2+ZC5sKsc8Q6Wwf58eHxzlGXuMrIDhWWA1K2+sPK39R0ISqhwjQl066Q09J66
 /UkR8KWf4QynrpNmJl9EA==
UI-OutboundReport: notjunk:1;M01:P0:gskIXJ0GWjE=;eJ52pGdnEz2LnH7fI4Q4+tMTd6j
 2glcrbUodL0CUD9c7phDCtChizScDsqF7zuFCmxLXlD8IIp/NAnsv1vzxKMA3kvi14T8gj6cf
 +Dl+1lcnYIolhWwSF239qK1TC970MSlRYrhi0reng12ljFccUh2C+FI9AoytpauoM1s4f18G7
 2ARVAaKo0uEOm903PuPm4w2ANd39ndeCmP8MHl42qL8a6TVc63QMTziyBpwaeFmNbG2HJiwE1
 Qs2coClF7pLhmQQ7I7RBftJMzxsEdhGDXfZH6lvICr76ih6eKi0gL3Qektz2+OpcMuvS1Qqdx
 LGCqJ16h2jcXsPX7N9IxjFswyDGyJ/K8pSGM3uvniQM8+0w8bQAlZi+LnuiE/Zs3STOhl+rBv
 Kd/BNEGzkdvNPKl1JK2VldyyKjROUbKh8IU/ep36BTQrKTpBCkQwlvRwjWGzJN1Mzhkhl5ZIh
 AGQIuU7TnwV60ykRJn06EOkFSKeyIcHrqEcHJlxPu8BxbW5+N+kDOVTjibBWZFrtfBh00uA2f
 ZC8OZxVRsbNISXpbXNEDnAlQLOHC30xGlYn7zLzXEJjRT6Xgr+ygheYH6GK5Tse2DRG1CAMO9
 Fp3fMVL7cYktw/6FmzvvW8iGABVnB+vdE/+togXpuUgtkFAK7uk5csXavPMgbV9ngqQMxaEk5
 hNLwl6LLQMJ/9WoTs789rNf7WI+uZWgL/BahxjD7WnsYvd6FgQ0ae/rBwp0WoXONwd4Kn7G6E
 DecLul7fqTVc6KRlxVLMq946ZBQjZuCint7rML8RPK1F6M2CAciplW//0CRJFcew8ojOGbz7O
 hTwootP55pz7cK+OqhlFfii1/QQWOFl+WF1DKLaCziCAo=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/23/24 16:58, Cole Robinson wrote:
> On 4/23/24 10:11 AM, Cole Robinson wrote:
>> Hi,
>>
>> hppa-firmware.img and hppa-firmware64.img in qemu.git are missing ELF
>> build-id annotations. rpm builds on Fedora will error if an ELF binary
>> doesn't have build-id:
>>
>> RPM build errors:
>>      Missing build-id in
>> /tmp/rpmbuild/BUILDROOT/qemu-9.0.0-1.rc2.fc41.x86_64/usr/share/qemu/hpp=
a-firmware.img
>>      Missing build-id in
>> /tmp/rpmbuild/BUILDROOT/qemu-9.0.0-1.rc2.fc41.x86_64/usr/share/qemu/hpp=
a-firmware64.img
>>      Generating build-id links failed
>>
>> I didn't hit this with qemu 8.2.* builds FWIW
>>
>
> Though checking older bundled hppa-firmware binaries with `readelf` I
> don't see build-id either, so now I'm not sure why those RPM builds were
> passing.
>
> FWIW the RPM check is deep in RPM code:
> https://github.com/rpm-software-management/rpm/blob/68d0f3119c3d46b6184f=
4704edb51749ce9f819e/build/files.c#L1976
>
> Maybe something else in hppa-firmware ELF headers caused this check to
> be skipped in the past

Maybe Fedora ignores binaries which don't have the executable flag set?
Qemu does not need it.
If so, a "chmod -x pc-bios/hppa-firmware*.img" should be sufficient.


Otherwise, adding "--build-id" to the link line when building the SeaBIOS
hppa-firmware.img does adds a build-id:

diff --git a/Makefile.parisc b/Makefile.parisc
index 5c34eb3d..256142f4 100644
=2D-- a/Makefile.parisc
+++ b/Makefile.parisc
@@ -169,7 +169,7 @@ $(OUT)hppa-firmware$(BIT_SUFFIX).img: $(OUT)autoconf.h=
 $(OUT)head.o $(OUT)ccode3
         @echo "  Linking $@"
         $(Q)$(CPP) $(CPPFLAGS) -Isrc -D__ASSEMBLY__ -DBITS=3D$(BITS) src/=
parisc/pafirmware.lds.S -o $(OUT)pafirmware.lds
         $(Q)$(CC) $(CFLAGS32FLAT) -c src/version.c -o $(OUT)version.o
-       $(Q)$(LD) -N -T $(OUT)pafirmware.lds $(OUT)head.o $(OUT)version.o =
-X -o $@ -e startup --as-needed $(OUT)ccode32flat.o $(LIBGCC)
+       $(Q)$(LD) -N -T $(OUT)pafirmware.lds $(OUT)head.o $(OUT)version.o =
-X -o $@ -e startup --as-needed --build-id $(OUT)ccode32flat.o $(LIBGCC)


deller@carbonx1:/home/cvs/LINUX/seabios$ eu-readelf -n out/hppa-firmware.i=
mg

Note section [ 1] '.note.gnu.build-id' of 36 bytes at offset 0x100:
   Owner          Data size  Type
   GNU                   20  GNU_BUILD_ID
     Build ID: 61a59ebba32fd40eadda7083983a1e1b04ec4082

Are you using the firmware blobs which come with qemu, or do you build Sea=
bios-hppa yourself?

Helge

