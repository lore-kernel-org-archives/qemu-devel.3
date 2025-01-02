Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6CDE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 09:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTHZL-000631-ST; Thu, 02 Jan 2025 04:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTHZG-00062j-EZ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 04:32:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tTHZC-0000w4-JP
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 04:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735810352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WD2z562YM8BXgXlTXOFHb9hnV4V9IMyW88XtBFpLwQE=;
 b=iY54PmX1sXGUGlQkbeKhVoOQvuDWmk1LPTNaRaIuhm4PLUuJwNHxw9Dz2lXpfOFB+mt96o
 j675mTNMZoROtSCk3kB/Tt0NzAoUA+MDMD90d/GJs0D8wt9EzQQs7UCvp531i7t5JXk3Ly
 yJdLKau3Bg6X+2MtJuiwvwTOrxMuGcY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-fsnGrmNhPYi9kz9eB3vktA-1; Thu, 02 Jan 2025 04:32:31 -0500
X-MC-Unique: fsnGrmNhPYi9kz9eB3vktA-1
X-Mimecast-MFC-AGG-ID: fsnGrmNhPYi9kz9eB3vktA
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4359206e1e4so86452435e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 01:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735810350; x=1736415150;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WD2z562YM8BXgXlTXOFHb9hnV4V9IMyW88XtBFpLwQE=;
 b=aw6492Lyc9AOMk5hpIwIDrgoikDvmi5aCJwavaeJ0C8M6o4tuUUE6S5ihQkUiVdxcZ
 +GcD66ofz705wonEFaxhzUBfdTcvDGjPMXPuzRMh9erlZ70lL/MVL9tkzNAEBLaXyT5o
 eQLislCTvHkLPs4usV3CAic/R5OMFaOAVtp94UdXK8GjY7WcK3ViLRbO6b58YUGTlJMx
 evNE2usATIVEc3sJopoOJ1NFPHxhy3dA9rbpYptWGO4NSw8czfPTLs8Dlh1unDXN6LFm
 JJEh8qsszfEnTu6eKMgya09toL4k5te230k85yY0nlf/xafckdPHdSyIJPdsIcygi4Dy
 xFAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpLOFz9vuCi7dX8piWjlu9/YB2tR92ZTJi7ADkAsaK7wfyPvqq1EbTAv17SMSU1sJnhEezjf/iS1IT@nongnu.org
X-Gm-Message-State: AOJu0Yzty996HM5Kkl6QqkxEHWhH3Ft2k7x2178ISP84sptIV2zOauVO
 tTVVHG5YyFI4un3Ll2YClYVulRr+nvOUBmiIuWeDdEuOOfMxYKgEOzwtTGrkBa495dEF8lGPD2S
 /bSdJznRkV6w1+D7zpYUhzXYf4iGa+L7YO2j5gJWn51mIvM9rbWYH
X-Gm-Gg: ASbGnctVOM+eS/aVUnAO3TsMFJi9aTjGDaQQnwp0UZJF6suOdmq5P5lRNUzVh88tFSn
 3Htt2aii+87toyh82uKljwFPxYCvjstvlOwGprVPXoobSOXL9a3ackzwKjNXVOLy7umMtIpaGwU
 WZDqeem/PdqqVmnn9DKbVtVDnyuHkUP17TEggsafB8UUF67anUzLYNrcN0opFvCS5XqYXrwS8A6
 ZWmGeFSg+VdYDSrRRDaAxHP91dEpr+ndNMVETDbgWeq6JFb7vYCPVL0erUmtZphPwmp7m/REA5p
 YyNbxTs0xncG
X-Received: by 2002:a05:6000:1a89:b0:382:3959:f429 with SMTP id
 ffacd0b85a97d-38a221e242emr45049634f8f.5.1735810350202; 
 Thu, 02 Jan 2025 01:32:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvLncq8+IcUHYkcjsXFssyyIdREr7vgb4vEEtb+XRonXxti3vFzgGd77Rqd406cxMxIvIy5A==
X-Received: by 2002:a05:6000:1a89:b0:382:3959:f429 with SMTP id
 ffacd0b85a97d-38a221e242emr45049602f8f.5.1735810349811; 
 Thu, 02 Jan 2025 01:32:29 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-148.web.vodafone.de.
 [109.42.51.148]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e69sm37262169f8f.35.2025.01.02.01.32.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 01:32:29 -0800 (PST)
Message-ID: <e5199fbb-e16e-4df0-a93d-5c0eecdc1ec7@redhat.com>
Date: Thu, 2 Jan 2025 10:32:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/17] Migration patches for 2024-12-17
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20241217174855.24971-1-farosas@suse.de>
 <20241219123213.GA692742@fedora> <87zfkrtsgt.fsf@suse.de>
 <Z2WbSZkEGSnA-BX9@x1n>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z2WbSZkEGSnA-BX9@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.186,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 20/12/2024 17.28, Peter Xu wrote:
> On Thu, Dec 19, 2024 at 03:53:22PM -0300, Fabiano Rosas wrote:
>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>
>>> Hi Fabiano,
>>> Please take a look at this CI failure:
>>>
>>>>>> MALLOC_PERTURB_=61 QTEST_QEMU_BINARY=./qemu-system-s390x UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 QTEST_QEMU_IMG=./qemu-img MESON_TEST_ITERATION=1 MSAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1:print_stacktrace=1 ASAN_OPTIONS=halt_on_error=1:abort_on_error=1:print_summary=1 PYTHON=/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/pyvenv/bin/python3 QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon G_TEST_DBUS_DAEMON=/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/tests/dbus-vmstate-daemon.sh /home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/tests/qtest/migration-test --tap -k
>>> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
>>> stderr:
>>> Traceback (most recent call last):
>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 688, in <module>
>>>      dump.read(dump_memory = args.memory)
>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 625, in read
>>>      section.read()
>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 461, in read
>>>      field['data'] = reader(field, self.file)
>>>    File "/home/gitlab-runner/builds/4S3awx_3/0/qemu-project/qemu/build/scripts/analyze-migration.py", line 434, in __init__
>>>      for field in self.desc['struct']['fields']:
>>> KeyError: 'fields'
>>
>> This is the command line that runs only this specific test:
>>
>> PYTHON=/usr/bin/python3.11 QTEST_QEMU_BINARY=./qemu-system-s390x
>> ./tests/qtest/migration-test -p /s390x/migration/analyze-script
>>
>> I cannot reproduce in migration-next nor in the detached HEAD that the
>> pipeline ran in (had to download the tarball from gitlab).
>>
>> The only s390 patch in this PR is one that I can test just fine with
>> TCG, so there shouldn't be any difference from KVM (i.e. there should be
>> no state being migrated with KVM that is not already migrated with TCG).
>>
>>> warning: fd: migration to a file is deprecated. Use file: instead.
>>> warning: fd: migration to a file is deprecated. Use file: instead.
>>
>> This is harmless.
>>
>>> **
>>> ERROR:../tests/qtest/migration-test.c:36:main: assertion failed (ret == 0): (1 == 0)
>>> (test program exited with status code -6)
>>
>> This is the assert at the end of the tests, irrelevant.
>>
>>>
>>> https://gitlab.com/qemu-project/qemu/-/jobs/8681858344#L8190
>>>
>>> If you find this pull request caused the failure, please send a new
>>> revision. Otherwise please let me know so we can continue to
>>> investigate.
>>
>> I don't have an s390x host at hand so the only thing I can to is to drop
>> that patch and hope that resolves the problem. @Peter, @Thomas, any
>> other ideas? Can you verify this on your end?
> 
> Cannot reproduce either here, x86_64 host only.  The report was from s390
> host, though.  I'm not familiar with the s390 patch, I wonder if any of you
> could use plain brain power to figure more things out.
> 
> We could wait for 1-2 more days to see whether Thomas can figure it out,
> hopefully easily reproduceable on s390.. or we can also leave that for
> later.  And if the current issue on such fix is s390-host-only, might be
> easier to be picked up by s390 tree, perhaps?

I tested migration-20241217-pull-request on a s390x (RHEL) host, but I 
cannot reproduce the issue there - make check-qtest works without any 
problems. Is it maybe related to that specific Ubuntu installation?

  Thomas


