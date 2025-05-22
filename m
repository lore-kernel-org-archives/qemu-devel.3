Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED35C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 18:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIAM0-0002CP-G1; Thu, 22 May 2025 14:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uIALf-0002Bn-DX
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:08:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uIALc-0004BQ-F1
 for qemu-devel@nongnu.org; Thu, 22 May 2025 14:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747937329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BvwywEJlYIWsR1toMRJdkKYnMAPjCjpD+0P7xsoQ+hs=;
 b=ffXssLFIAtGstBEOopgzKGo5Zv43l8V1XzSXLjVFvpci6bki73lVMSWilOGuJKRqShCqAl
 DXKv4C01jO3ESBY3PoJwEPADmeVefjqHDO87ooYy9v4tUJFESwv2nA7EXEfcz9vlE2ngy4
 LTcikM3WsgSZKFyl8B8/CbbmcRniqlY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-CgWe042ePy2lb2MRohm4NQ-1; Thu, 22 May 2025 14:08:48 -0400
X-MC-Unique: CgWe042ePy2lb2MRohm4NQ-1
X-Mimecast-MFC-AGG-ID: CgWe042ePy2lb2MRohm4NQ_1747937327
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a35ec8845cso3590933f8f.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 11:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747937327; x=1748542127;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BvwywEJlYIWsR1toMRJdkKYnMAPjCjpD+0P7xsoQ+hs=;
 b=jBSPfvtPE9GELgluJtjrltTgWnukyDVHGRFahaH6c/dxQgWT7NRmmH9DZscCFegDqA
 oarcU08/SAg2jL1UwMnYyoqWfxY1hJsvbxfJfQJeaHLw2Er2u+vrsOZOicWUQc5UsPC3
 3thkRvyJ8mPeJ+n6cVaSvrNgwz3tM7kd8FKXvxH3gyTFENE8J04vGNwuhTKPhnJCjkQY
 DxIA5aUcu7EcS6LnI2mi11ypB1E0ABBAhZ8WKkhwFNV9R1J+DQOZE7SP+53Nha9EMc/q
 F9dN+UYkR0qJ9ljxnZ9SOSGody6DqwmGNXpCYxO/syyLkKIL0hj0RFfIggOtpgb3Bk2F
 JE2w==
X-Gm-Message-State: AOJu0YxDpP+rmBS5kouPHrBVdobzkjJ7VjoEZRskx2FfVZk0HijDiFr4
 EaGBFFyrWZf4CeGFkqi7cT9BC78NXVNFZ1FEoxUUhWEuI5P5RpWdIzAxVaVKA3DtcJQatXbpCpN
 xWu26v124+0CZqH53bs/60wEe5FQzeU2XB+/9bVY/At+GAiU5x7EpCdjd
X-Gm-Gg: ASbGnctxZpmXp+pofdwZxTRzOyuLFYeJ8N/si/PfloKnMoq2AZiNfb7LeJsnVGkdX55
 AZRF0zshNEz8UoWYMETH4LEDcFtJTm5S6DFD6nUSmlbfGk7SrLAqnj4Rz2o4R993Z5/qpwG8d5e
 1Jpi0dbWtvW951sBgmDCT4QPU+7gcsf1aZgEJKdan7zgyrD/asIuPFTCYRkFPvefhpMERrKwZRY
 CurJAjIjHQOZCY/ZhYod7WsivqUPo/vvyhHGDtVW4IK1EV1dxpfZqdjs8gMF1/yS1MDYJtjOIRN
 ZzHi308wYBLp9hHMa01ROlECbbhN899qXARGzxo40H0=
X-Received: by 2002:a05:6000:4308:b0:3a4:741d:35c1 with SMTP id
 ffacd0b85a97d-3a4742c7bd9mr7041313f8f.36.1747937326880; 
 Thu, 22 May 2025 11:08:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+EoCGQXsLzu0j1jMQN/Yjl7WKTSmxbv9GzuTdn8yzHOL/M/Y+NyVnYtgcLD6pVv8gniLCgQ==
X-Received: by 2002:a05:6000:4308:b0:3a4:741d:35c1 with SMTP id
 ffacd0b85a97d-3a4742c7bd9mr7041290f8f.36.1747937326488; 
 Thu, 22 May 2025 11:08:46 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a37b0bbd1fsm9513806f8f.100.2025.05.22.11.08.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 11:08:45 -0700 (PDT)
Message-ID: <2f83dee7-6bfc-435e-8392-2236b98cbcfe@redhat.com>
Date: Thu, 22 May 2025 20:08:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] tests/functional: Test with
 scripts/vmstate-static-checker.py
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20250522133756.259194-1-thuth@redhat.com>
 <20250522133756.259194-4-thuth@redhat.com> <aC820hzwtrFBV9oq@x1.local>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aC820hzwtrFBV9oq@x1.local>
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

On 22/05/2025 16.38, Peter Xu wrote:
> On Thu, May 22, 2025 at 03:37:55PM +0200, Thomas Huth wrote:
> 
> [...]
> 
>> +    def test_vmstate(self):
>> +        target_machine = {
>> +            'aarch64': 'virt-7.2',
>> +            'm68k': 'virt-7.2',
>> +            'ppc64': 'pseries-7.2',
>> +            's390x': 's390-ccw-virtio-7.2',
>> +            'x86_64': 'pc-q35-7.2',
>> +        }
>> +        self.set_machine(target_machine[self.arch])
>> +
>> +        # Run QEMU to get the current vmstate json file:
>> +        dst_json = self.scratch_file('dest.json')
>> +        self.log.info('Dumping vmstate from ' + self.qemu_bin)
>> +        cp = subprocess.run([self.qemu_bin, '-nodefaults',
>> +                             '-M', target_machine[self.arch],
>> +                             '-dump-vmstate', dst_json],
>> +                            stdout=subprocess.PIPE,
>> +                            stderr=subprocess.STDOUT,
>> +                            text=True)
>> +        if cp.returncode != 0:
>> +            self.fail('Running QEMU failed:\n' + cp.stdout)
>> +        if cp.stdout:
>> +            self.log.info('QEMU output: ' + cp.stdout)
>> +
>> +        # Check whether the old vmstate json file is still compatible:
>> +        src_json = self.data_file('..', 'data', 'vmstate-static-checker',
>> +                                  self.arch,
>> +                                  target_machine[self.arch] + '.json')
>> +        self.log.info('Comparing vmstate with ' + src_json)
>> +        cp = self.run_vmstate_checker(src_json, dst_json)
>> +        if cp.returncode != 0:
>> +            self.fail('Running vmstate-static-checker failed:\n' + cp.stdout)
> 
> Would false positives happen here?  Would it fail "make check" and CI, even
> if the change was intended?

Yes. In that case, the quick fix is to remove the problematic piece from the 
7.2 json files. Or we could try to improve the vmstate-static-checker 
script. At least we now notice it immediately, not only after a long delay 
until someone runs the script manually again.

But yes, this can be confusing for the who runs into this problem for the 
first time. I guess I should at least add some friendly words here with 
instructions what has to be done?

  Thomas


>> +        if cp.stdout:
>> +            self.log.warning('vmstate-static-checker output: ' + cp.stdout)
>> +
>> +
>> +if __name__ == '__main__':
>> +    QemuSystemTest.main()
>> -- 
>> 2.49.0
>>
> 


