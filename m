Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FD3C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 18:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIAPj-00035d-Lw; Thu, 22 May 2025 14:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uIAPZ-00035G-Ug
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uIAPX-0004xA-VO
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747937574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=70UdrXPVQmFKawyGMtWO82zzWXuyLgcyHBazAmwTAO8=;
 b=cU952obMxzZESYF5twE9p3kdEG1dsSn0mCFQMUY5Pi0fwixfG3b0vegovGc4np4BrZt+vh
 PbFvf+XwFmnBtzbKVrBdAsDDpprMVLryZEq3jALMFmu7YApMXh2Tbz/YkYkCXyeAzr6nwD
 XKQ8Ffpkjwyk+ivxox4/w2n/PvS0J14=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-5wXPoMnxO1-tYkreDWFqxQ-1; Thu, 22 May 2025 14:12:52 -0400
X-MC-Unique: 5wXPoMnxO1-tYkreDWFqxQ-1
X-Mimecast-MFC-AGG-ID: 5wXPoMnxO1-tYkreDWFqxQ_1747937571
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a3660a9096so2598549f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 11:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747937571; x=1748542371;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=70UdrXPVQmFKawyGMtWO82zzWXuyLgcyHBazAmwTAO8=;
 b=fnbMu2zYi62i9mSGqlNYaoKIavtNOJrsZU6cHsTUG+SzXiRMEeNaVOUO1xiv3zxXt/
 omF/cVLorMn8YyuKazDMyC/WZqa5eNLLl8/lFfT/Un/NkR3QWKcsZuG8H7oEeiQIGLRk
 wdh53ntrnHKKlqFtjM6WEON2+ouS+0kCIEZjxjLzL3I9IN9KZHqYwnmb3hw4AFFUbGow
 wxTo1GrWUXO6geTiukXcpJUpM1AecAtZ47/TqKp50UF/yX/rzbSpH3IlNnDieiOXo2zl
 M0AcA0NQwv8bCtS3NTJcfla2LBYepdru203gQwoFwvdzbQ+Xt6PKNWr3yDrehSQt2JHT
 GajA==
X-Gm-Message-State: AOJu0YxpeRoJYTunVI6SxuzPI4laaSQxmoaoYLNboB4RYkDRC3bJpLlS
 708GCewoUgBDiPPNdIo+A6kXWBF62MQ6VnYr0IOueh6LwGzbtkSRzkvHSTFFSsHhPO5+d5BA9x0
 5deqlDgAL7LTecVVlxxa5rifkO753utx6/oq3s1O2PhdEHgDyUfrplenb
X-Gm-Gg: ASbGncsPhxnjhVTBKVU0rdjkb5ZOUM+2BzDuxkxMnAJym7uDD2qHb0imr2njyKep3+9
 inov3LppuV4elBPJox5MWEIzCGPex6hBiSTtH4hFci5pzFtiJqGGuAjzFpSbaiCVHlArcsq0eVc
 MbRrEYBf0d7SgvatvvmnBnHD+1G0pOpWHa53dUuyuF0KOr+eEhuQG9l6qC4asbzvPywkyYY0LfQ
 egm8fFYct2ceTAk3KFgAF0epBwT2mDqfBmtN52BuSoow842kYwDBdPSxfXo645XGmoRCnrEEe11
 POtyCZ8GCPGXCG9cwu0+rTBPR7e6dstvWwRpIu/UZ+c=
X-Received: by 2002:a5d:64ee:0:b0:3a0:8291:20d0 with SMTP id
 ffacd0b85a97d-3a35c83f19bmr23609520f8f.29.1747937571422; 
 Thu, 22 May 2025 11:12:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHghyrHqyoRyxEEJ6E5uCseCzMPYCinlDSPG56o0Ot2RQNNtv6eb9Lu/+chWHvvPTRbu7wYg==
X-Received: by 2002:a5d:64ee:0:b0:3a0:8291:20d0 with SMTP id
 ffacd0b85a97d-3a35c83f19bmr23609504f8f.29.1747937571040; 
 Thu, 22 May 2025 11:12:51 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f45a8434sm121749385e9.0.2025.05.22.11.12.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 11:12:50 -0700 (PDT)
Message-ID: <1fa7b5a7-585b-415d-900b-092f9ec13c52@redhat.com>
Date: Thu, 22 May 2025 20:12:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] tests/functional/test_vmstate: Test whether the
 checker script works as expected
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20250522133756.259194-1-thuth@redhat.com>
 <20250522133756.259194-5-thuth@redhat.com> <aC83QUmY6B255lTb@x1.local>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aC83QUmY6B255lTb@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 22/05/2025 16.40, Peter Xu wrote:
> On Thu, May 22, 2025 at 03:37:56PM +0200, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> We've got two vmstate dump files in the repository which are meant
>> for verifying whether the vmstate-static-checker.py works as expected.
>> Since running this manually is a cumbersome job, let's add an automated
>> test for this instead that runs the script with the two dump files
>> and checks for the expected output.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/test_vmstate.py | 37 ++++++++++++++++++++++++++++++++
>>   1 file changed, 37 insertions(+)
>>
>> diff --git a/tests/functional/test_vmstate.py b/tests/functional/test_vmstate.py
>> index cc988987481..19a62e8a17e 100755
>> --- a/tests/functional/test_vmstate.py
>> +++ b/tests/functional/test_vmstate.py
>> @@ -9,6 +9,22 @@
>>   from qemu_test import QemuSystemTest
>>   
>>   
>> +expected_output='''Warning: checking incompatible machine types: "pc-i440fx-2.1", "pc-i440fx-2.2"
>> +Section "fw_cfg" does not exist in dest
>> +Section "fusbh200-ehci-usb" version error: 2 > 1
>> +Section "fusbh200-ehci-usb", Description "ehci-core": expected field "usbsts", got "usbsts_pending"; skipping rest
>> +Section "pci-serial-4x" Description "pci-serial-multi": Entry "Fields" missing
>> +Section "intel-hda-generic", Description "intel-hda", Field "pci": missing description
>> +Section "cfi.pflash01": Entry "Description" missing
>> +Section "megasas", Description "PCIDevice": expected field "irq_state", while dest has no further fields
>> +Section "PIIX3-xen" Description "PIIX3": minimum version error: 1 < 2
>> +Section "PIIX3-xen" Description "PIIX3": Entry "Subsections" missing
>> +Section "tpci200": Description "tpci200" missing, got "tpci2002" instead; skipping
>> +Section "sun-fdtwo" Description "fdc": version error: 2 > 1
>> +Section "sun-fdtwo", Description "fdrive": Subsection "fdrive/media_rate" not found
>> +Section "usb-kbd" Description "usb-kbd" Field "kbd.keycodes" size mismatch: 4 , 2
>> +'''
>> +
>>   class VmStateTest(QemuSystemTest):
>>   
>>       def run_vmstate_checker(self, src_json, dst_json):
>> @@ -19,6 +35,27 @@ def run_vmstate_checker(self, src_json, dst_json):
>>                                 stderr=subprocess.STDOUT,
>>                                 text=True)
>>   
>> +    def test_checker(self):
>> +        """
>> +        Test whether the checker script correctly detects the changes
>> +        between dump1.json and dump2.json.
>> +        """
>> +        if self.arch != 'x86_64':
>> +            self.skipTest('for x86 only')
>> +        src_json = self.data_file('..', 'data', 'vmstate-static-checker',
>> +                                  'dump1.json')
>> +        dst_json = self.data_file('..', 'data', 'vmstate-static-checker',
>> +                                  'dump2.json')
>> +        self.log.info(f'Comparing {src_json} with {dst_json}')
>> +        cp = self.run_vmstate_checker(src_json, dst_json)
>> +        if cp.returncode != 13:
>> +            self.fail('Unexpected return code of vmstate-static-checker: ' +
>> +                      cp.returncode)
>> +        if cp.stdout != expected_output:
>> +            self.log.info('vmstate-static-checker output:\n' + cp.stdout)
>> +            self.log.info('expected output:\n' + expected_output)
>> +            self.fail('Unexpected vmstate-static-checker output!')
>> +
> 
> Would this run for every make check and every CI run?

Yes.

> Since the script almost never change, I wonder whether this test should be
> triggered only if manually.

We could disable it by default with a @skip... decorator, but I think it's 
not really worth the effort: The runtime of test_checker() is about 100 ms, 
that's really nothing compared to the hunders of seconds that some other 
tests take.

  Thomas


