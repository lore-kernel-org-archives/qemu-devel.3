Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D09DEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 03:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sns1F-0000Ze-UP; Mon, 09 Sep 2024 23:58:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sns1D-0000YX-Vz
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 23:58:20 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sns1B-0006FB-SD
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 23:58:19 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7d916b6a73aso1100118a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 20:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725940696; x=1726545496; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b6Ygp3KxJtVt5paKEJ8MT0i9eDhcBLerQFd6zDp8+LY=;
 b=KcwXKHmJNxOq2irSBM4+bBq61UhtUQA3DS+ndBxIODqZ3WamrHU8X6hgqjLXGa7X3G
 zIfvZaoxAvZ+g9ESolr5xZgFauIWAcUlGaDD2KSFFpZODjA9EiZY9XrPa8g8UFWRTHHa
 EgMe5ukNry/RY5QehKl10l8dBx/Zsgod4Nh2znppLOvxonINwVla9ZjSCRmR5Rv6g+8u
 ZZNxWjgmU9lDmj6bXG1Jg8xcV8jiT8oXZewERd+bRWlBIVKcIqbPfmHcHME9u2Etim+4
 lcLfVq42T65W+LC4pA7L965IoA/46si6o/mfT3LTQCLT4Y1TYkFJsdMDgLV96OlMyscT
 RrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725940696; x=1726545496;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=b6Ygp3KxJtVt5paKEJ8MT0i9eDhcBLerQFd6zDp8+LY=;
 b=Cw/w9BcevMXGz6a1Pgm8s1CEzVMT0XsdPsPmZhN6yKfE/1rIx681frfSx7AmZMCRul
 0SycHQ25nAhTx6c8vSc2/p4ZeWTsQyP2kwfpobw07XsRXTZg0pppiZzDtNmqANLzPuGf
 pmzy4+s9rpdtLo2WTe+L5F+NWYXNwKods9HRc7p0wf7VJd5cnVN8WLDpVS9+q5F0k8rf
 kDWe1wI0k/6B1Hp/qicHAoD+sUTFLfJc3TXDzfc+zYAXLDpyoEVeDb81hutoMtTQKFxz
 p7lSy6VIrm3gi0HAKgkIT+RhPFChZoOxEJ09PPElwbnqZllEDiCSonnsF8Bpoy4J0vD0
 3FKA==
X-Gm-Message-State: AOJu0Yw5D5nQp5/p8+rqc7KQ9/aoc5BzRuXSFy/8N5BgbQAKFns+ojYi
 f6RDZJAwkHPHJJdrs2cAzp/u6j9dUcC3w+SS7JhP5klihQkzHC1KHmu8OSYX0a0LpIa80c7RAuM
 F
X-Google-Smtp-Source: AGHT+IEPQ/EtNneuri4r/A1ADJTrtGEZa8seW7QKJ6o8yFhtJjyw9pxe8cfPszZXOq0XBrfmmDf2XA==
X-Received: by 2002:a17:90b:1092:b0:2d3:ce99:44b6 with SMTP id
 98e67ed59e1d1-2dad517f7afmr11836419a91.29.1725940695486; 
 Mon, 09 Sep 2024 20:58:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadbfe4897sm7490944a91.7.2024.09.09.20.58.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 20:58:15 -0700 (PDT)
Message-ID: <5f193fa1-89ec-4424-b6fd-c7ae1a4beedf@linaro.org>
Date: Mon, 9 Sep 2024 20:58:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Subject: check-functional skipUnless failure
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

[rth@cfarm120 bld]$ make check-functional
[1/2] Generating tests/functional/func-precache-m68k-m68k_nextcube with a custom command 
(wrapped by meson to set env)
FAILED: tests/functional/m68k-m68k_nextcube.tstamp
env QEMU_TEST_PRECACHE=/home/rth/qemu/bld/tests/functional/m68k-m68k_nextcube.tstamp 
PYTHONPATH=/home/rth/qemu/src/python:/home/rth/qemu/src/tests/functional 
/home/rth/qemu/bld/pyvenv/bin/python3 
/home/rth/qemu/src/tests/functional/test_m68k_nextcube.py
Traceback (most recent call last):
   File "/home/rth/qemu/src/tests/functional/test_m68k_nextcube.py", line 25, in <module>
     class NextCubeMachine(QemuSystemTest):
   File "/home/rth/qemu/src/tests/functional/test_m68k_nextcube.py", line 60, in 
NextCubeMachine
     @skipUnless(tesseract_available(4), 'tesseract OCR tool not available')
   File "/home/rth/qemu/src/tests/functional/qemu_test/tesseract.py", line 16, in 
tesseract_available
     (stdout, stderr, ret) = run_cmd([ 'tesseract', '--version'])
   File "/home/rth/qemu/src/tests/functional/qemu_test/cmd.py", line 69, in run_cmd
     subp = subprocess.Popen(args,
   File "/usr/lib64/python3.9/subprocess.py", line 951, in __init__
     self._execute_child(args, executable, preexec_fn, close_fds,
   File "/usr/lib64/python3.9/subprocess.py", line 1837, in _execute_child
     raise child_exception_type(errno_num, err_msg, err_filename)
FileNotFoundError: [Errno 2] No such file or directory: 'tesseract'


On this host, tesseract is not available.
But skipUnless is not skipping, but erroring out.


r~

