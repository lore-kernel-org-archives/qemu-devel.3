Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46BEEDE9AB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 19:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so6ue-0004pw-2G; Tue, 10 Sep 2024 15:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so6ub-0004gp-Cr
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 15:52:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1so6uY-0001oq-S8
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 15:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725997945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RyZPXtSGoXBlUicoXkQATaKF1znGDD7yLv90noGJvSE=;
 b=bFfgS0Z89fClx4hDlrkYngRD9EVYRR8s75bWfYA/jky1809KK5cSCPlyIEMgF5NCwQy6vb
 a/caU2yuU4gVDLoBXWns6LhixSRVe+AHqQSpzyYS838zkd9bENL4LyeCFFER5g+GW1d3Sj
 GTOwHlGgArPCAfXrobAtWDthRpQF77o=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-_H-N0fjTOEqrCrOVw7Cpjw-1; Tue, 10 Sep 2024 15:52:23 -0400
X-MC-Unique: _H-N0fjTOEqrCrOVw7Cpjw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-45828d941f1so54656891cf.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 12:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725997943; x=1726602743;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RyZPXtSGoXBlUicoXkQATaKF1znGDD7yLv90noGJvSE=;
 b=ZVovbyct5jSRnVMvu2UWrvbleP+l1k9qkRxSLeC/2TvErmryyauSTpbGzdLfUWZkFq
 haLHSvgh0yTsTpPmdAptC+dA63BAs6m0k0ZaWAmYTjWJTs76ODH0gYs83fN4r+Br3Hjb
 zmW65zK1Uu34c2HeUrn2gg6pJIHRoYiNGxGfG+0APFcQw/PSS5+F03RMok6+lwQ3m763
 j9plxjJjjIG8pvUNR+rU9HlTsGoHfdyFxR/oX8TS4i1aUAUklfUr2LIG5WjZySy81UtN
 uyLNNhwmoNhP+2xqapzcLCSniGustOU3e1paVwM3ymKMGf9hSL6W1KkXpwbuLytbVZ5X
 EWPQ==
X-Gm-Message-State: AOJu0YyAlrA3IGnM+F49anDI7qspH3KOAmmg6+RP/NNmPWJ49Elkaea8
 mm2f7+AXKNqkNPd8ZgdM/tN6llAoSZ4hcdgHCQqdn1SxvFWBnd6xebmuj5EPWvYLzaLu5HBPa1D
 0YeYKwDFWbiWtgvkHhqKvER5B7FLqHFjXHlxIdBmuklbiYT1waRfH
X-Received: by 2002:a05:622a:1a95:b0:458:4e4c:b68f with SMTP id
 d75a77b69052e-4584e4cbd60mr9964351cf.46.1725997943299; 
 Tue, 10 Sep 2024 12:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdVxMCDJy2cXkvj2pvVdfO3jF2wzEQ52m9FOkCJmayiX2pj/kPdovugIfjc18iYUWxBZZU6Q==
X-Received: by 2002:a05:622a:1a95:b0:458:4e4c:b68f with SMTP id
 d75a77b69052e-4584e4cbd60mr9964111cf.46.1725997942906; 
 Tue, 10 Sep 2024 12:52:22 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-178-122.web.vodafone.de.
 [109.43.178.122]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822f608b9sm32292051cf.64.2024.09.10.12.52.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 12:52:22 -0700 (PDT)
Message-ID: <3be9f503-5c73-49c7-8df4-184cfd05ff0f@redhat.com>
Date: Tue, 10 Sep 2024 21:52:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/22] Tests and misc patches
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240910123726.182975-1-thuth@redhat.com>
 <CAFEAcA_f1hMj=6wXzv2ZYuFVGDbaOpDOPzZrh3VAYqup06dXDg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA_f1hMj=6wXzv2ZYuFVGDbaOpDOPzZrh3VAYqup06dXDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/09/2024 17.38, Peter Maydell wrote:
> On Tue, 10 Sept 2024 at 13:37, Thomas Huth <thuth@redhat.com> wrote:
>>
>> The following changes since commit 7bbadc60b58b742494555f06cd342311ddab9351:
>>
>>    Merge tag 'crypto-fixes-pull-request' of https://gitlab.com/berrange/qemu into staging (2024-09-09 15:19:32 +0100)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/thuth/qemu.git tags/pull-request-2024-09-10
>>
>> for you to fetch changes up to cc3e005eb22332ba277bff2e39025d0087f3795e:
>>
>>    tests/functional: Fix bad usage of has_cmd (2024-09-10 13:44:42 +0200)
>>
>> ----------------------------------------------------------------
>> * Split --enable-sanitizers to --enable-{asan, ubsan}
>> * Build MSYS2 job using multiple CPUs
>> * Fix "make distclean" wrt contrib/plugins/
>> * Convert more Avocado tests to plain standalone functional tests
>> * Fix bug that breaks "make check-functional" when tesseract is missing
>>
>> ----------------------------------------------------------------
> 
> On the 'make check-vm-openbsd' test I run:
> 
> 595/944 qemu:func-quick+func-mips64el /
> func-mips64el-mips64el_fuloong2e          ERROR            6.16s
> exit status 1
> 602/944 qemu:func-quick+func-or1k / func-or1k-or1k_sim
>             ERROR            6.91s   exit status 1
> 
> Slightly more detail further up in the log:
> 
> 
> 595/944 qemu:func-quick+func-mips64el /
> func-mips64el-mips64el_fuloong2e          ERROR            6.16s
> exit status 1
> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
> stderr:
> Traceback (most recent call last):
>    File "/home/qemu/qemu-test.fsnflZ/src/tests/functional/test_mips64el_fuloong2e.py",
> line 29, in test_linux_kernel_3_16
>      deb_path = self.ASSET_KERNEL.fetch()
>    File "/home/qemu/qemu-test.fsnflZ/src/tests/functional/qemu_test/asset.py",
> line 135, in fetch
>      if not self._check(tmp_cache_file):
>    File "/home/qemu/qemu-test.fsnflZ/src/tests/functional/qemu_test/asset.py",
> line 52, in _check
>      checksum = subprocess.check_output(
>    File "/usr/local/lib/python3.10/subprocess.py", line 421, in check_output
>      return run(*popenargs, stdout=PIPE, timeout=timeout, check=True,
>    File "/usr/local/lib/python3.10/subprocess.py", line 503, in run
>      with Popen(*popenargs, **kwargs) as process:
>    File "/usr/local/lib/python3.10/subprocess.py", line 971, in __init__
>      self._execute_child(args, executable, preexec_fn, close_fds,
>    File "/usr/local/lib/python3.10/subprocess.py", line 1863, in _execute_child
>      raise child_exception_type(errno_num, err_msg, err_filename)
> FileNotFoundError: [Errno 2] No such file or directory: 'sha256sum'
> 
> 
> (test program exited with status code 1)
> 
> 
> Similarly for the or1k failure.
> 
> If you want to use sha256sum in "make check" then we should
> ensure that it's installed in these BSD VM images.

Ok ... I'm looking into using the hashlib from Python instead, that way 
we'll be independent from external binaries here.

> Also, does this mean that "make check" is now going to run
> a lot of the tests that were previously in "make check-avocado"?
> That seems like it might make our CI jobs take longer...

No, it will only some basic tests that don't download any assets. These 
should be the rather quick ones.

  Thomas


