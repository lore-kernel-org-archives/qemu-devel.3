Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380FCCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 16:20:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyBug-00076a-JN; Mon, 15 Sep 2025 12:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uyBub-00076I-LE
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:18:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uyBuS-0004Y4-Nc
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 12:18:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757953107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XPpVmYcOYol0GHffCiEg67aOcEys5xMmIXEnW2nOsH0=;
 b=OY1lFjMT9nEGMkjq9B6flF/yOyg5520zlbZ/FXjwSAbJxGPXXazb+AtHeu54WC4SS0eviF
 Cb7/zUQmFr70Y2NtWs1M6KYzLaGxfXmRCFoC/HyXvWI4L4WeQ+r6EVS5Bcs1c2yauPMWbQ
 RaDrDVko7sCyYwgAJF+YQCFgmcWW5Zk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-AXW1omsMMu-44H1aDxcQOw-1; Mon, 15 Sep 2025 12:18:25 -0400
X-MC-Unique: AXW1omsMMu-44H1aDxcQOw-1
X-Mimecast-MFC-AGG-ID: AXW1omsMMu-44H1aDxcQOw_1757953105
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b990eb77cso29720565e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 09:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757953104; x=1758557904;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XPpVmYcOYol0GHffCiEg67aOcEys5xMmIXEnW2nOsH0=;
 b=ibg/4OrRpfVk5zVCR58gq8HOqwiv/6uzmb35B0leDuQtwzKFxXeCnensYvGa/6ij4q
 6CQj69IaT8+SueebtpKC0xGWhgoX2QgBopgLvCqp4yVeu2PlO1DtXMSifrAXjJ14aryA
 0oIHiEAUcTqTfulu9C8bR889/iJpPGot4tUBT3vMZH4SrZgKEfWmGAjEpULbTOvmfyZm
 0H6xcRj5myE1C7uZLhojKErB4MW2FSc1BwDi1MCR4ECmyQEe92rAKX2L3ZhtENR43mNU
 90yV+J9sEOodKh3qhiXa9GAv/4ZXKkCC93TR5NFKvUUq+0R7aySvLIop8KbGvEH1GmhE
 cChg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/80NkwCAFaFnRefldTnx4ENsLaIQHCrFD7UExODxT8SBMntboSfw5sNKEAMt6iSmiIMa+PsLshlHa@nongnu.org
X-Gm-Message-State: AOJu0YxyvMrtMu4KuWS2UwtfSuvHMon8J+w1K++yudO1ZMHERSyp3T/u
 ttZK0BhPMCOkYYZmHq2lTA9NuJi/fLctIukyzGVWnF+sV7resXTfAgNNHlmNag/1w4Q0GISgNon
 ARR8VGtRMzbViVe+MFmECtUq77/yK08aZyHlMkpCoIJqhVz6lB0Dj67BcxbdVunfV03A=
X-Gm-Gg: ASbGncs0ULIraTivCA7zW9Jf+Xka3nypa/DU9Bp2jcHq2aUxzq5t0ui3iPQfs2MCFTV
 +6zjz0hbZ96bNPYtlXJ8hV1U2EuBLG+Iu8V0MTe03AIuCTxVKBKpx5XphblNwJlVklA3fOn7XBw
 /SCrVhjIbM+17Dkx7rmNwNggS3PnjXxK8u4K3vK0rl2gSX3xbL5otLGwqlvm67AxxRwyONW5ND6
 OygWwl/Cly3RlsFhyRKGf1bt0I9bYYOPdby/0vF/1evPSfpv0TN7qBAuR6yuDKWRZVOW5R/hW1C
 XAOCb2Pwk4ws3CWdy367Z9YMEVcIjsYmikvjP3lUx5+MMFCeB/EazggMRXZ31/GDJAJlQey4Ez1
 YRwSXZA==
X-Received: by 2002:a05:600c:3146:b0:45d:dc6c:9e30 with SMTP id
 5b1f17b1804b1-45f21293373mr142049755e9.14.1757953104550; 
 Mon, 15 Sep 2025 09:18:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEc7DjW0Q15/fk3waHesm5DqOMGPSBnyrKAV3dJSg/HEJVP+WagPuS/Z28e7MeLXwYSpVJOdg==
X-Received: by 2002:a05:600c:3146:b0:45d:dc6c:9e30 with SMTP id
 5b1f17b1804b1-45f21293373mr142049375e9.14.1757953104120; 
 Mon, 15 Sep 2025 09:18:24 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-183.pools.arcor-ip.net.
 [47.64.113.183]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e8237cfdddsm11697157f8f.60.2025.09.15.09.18.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 09:18:23 -0700 (PDT)
Message-ID: <d735ec67-dc45-438c-9151-6ced6ff49b77@redhat.com>
Date: Mon, 15 Sep 2025 18:18:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] tests/functional: Adapt reverse_debugging to run
 w/o Avocado (yet another try)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org
References: <20250915124207.42053-1-thuth@redhat.com>
 <875xdjpubx.fsf@draig.linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <875xdjpubx.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 15/09/2025 18.13, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> Here's yet another attempt to remove the avocado dependency from the
>> reverse debugging tests: I basically took Gustavo's patches to rework
>> tests/functional/reverse_debugging.py, but instead of calling that
>> through tests/guest-debug/run-test.py and adding the cumbersome code
>> to support additional test execution logic, I kept our normal way of
>> running tests via pycotap.
> 
> Hmm I was getting:
> 
>    2025-09-15 17:10:50,798 - INFO: GDB CMD: /home/alex/src/tools/binutils-gdb.git/builds/all/install/bin/gdb -q -n -batch -ex 'set pagination off' -ex 'set confirm off' -ex "py sys.argv=['/home/alex/lsrc/qemu.git/tests/functional/reverse_debugging.py']" -x /home/alex/lsrc/qemu.git/tests/functional/reverse_debugging.py
>    2025-09-15 17:10:50,803 - DEBUG: Using cached asset /home/alex/.cache/qemu/download/7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379cbbf7 for https://archives.fedoraproject.org/pub/archive/fedora/linux/releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz
>    2025-09-15 17:10:50,891 - INFO: gdb output:
>     Python Exception <class 'ModuleNotFoundError'>: No module named 'pycotap'
>    Error occurred in Python: No module named 'pycotap'

Ah, sorry, I have it installed pycotap system-wide, too, so I did not notice 
it... I'll fix it in the next version if we decide to proceed with this 
approach instead of using one of the others.

  Thomas


