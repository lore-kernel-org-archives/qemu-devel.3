Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998BFCD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 13:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN9Go-00047Q-Mg; Wed, 13 May 2026 09:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN9Gm-000477-E6
 for qemu-devel@nongnu.org; Wed, 13 May 2026 09:05:00 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wN9Gk-0002Cv-JZ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 09:05:00 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891f625344so61837425e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778677495; x=1779282295; darn=nongnu.org;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZCFAGjJ3dUranATZp43tZxigMYPghNsOBYDQIvIk31s=;
 b=O/OtqY9lrn0x+dciokgx1j7/qx4bi1QLJ1SaQobHOY+avyDh0fPr/xBVkefnPIMn+q
 9swAqYvw/N1fXbfzUJoEZ/LA6VYHiPOqo1lsPIYfFT47WdVgZiAI4yq26CUSBDBbS1pW
 9VIGiTyqwfcsGHunKZ0QkmUM7WAX6xXQedX+/N5Q8xCD5LsXXD2CLucs6Ml/SA8dgI/h
 LI+yTJA5PvoDrrOTcG4hnLfU7cdecBIqG4RzS422FCQotQv4RlQDizSgVfR+X6e5qG74
 1wwappA1Tn6bHd7Idnkr7yRtoA7AbbSCCHy/eeJ65j1gFKwLziuZFuaSt+DLG8NERZ0n
 acsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778677495; x=1779282295;
 h=content-transfer-encoding:subject:cc:to:content-language:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZCFAGjJ3dUranATZp43tZxigMYPghNsOBYDQIvIk31s=;
 b=bGpt4S1KAVArXEatI1UKPLhKlGwW8C3KjBIhMA0FdVGxTMfmpzuLoYO/6hymQt3fYw
 mRYw+bPdbGb0c1SB1hbv4rb64bAKUdCGEk/ZvZasiT/Pf2G85arCKRGgo4dGPrRoiee2
 7YDB+mP7wZLtfwpbU5QGsuH6zpOZ9R4/TFeckjTNROhJh5iAKWEGUQVLkmmyTiKKh1G1
 4qrMkEQAdn27lU4Vpon+WMv6+Fj6ZAcvGc6bDVgC+QvhjuTU7l0nqHFUUiVfmuHhSW38
 PJ1adXCjo7sSNj0+AUBnAotwAHQka41EtlmSpToCuprwSKtNKdWeNbmFHoRAXfLvWbHZ
 2+Ow==
X-Gm-Message-State: AOJu0YypGVfgKtUHqsJPQcuANUnGHDxZqdPx2GKss+/TzV7RafP7QDix
 h1Ek7ebfn9R6YsRBBKFnQGCSd/V6RUk/DXbbbBVTgZTcCXU0htiH2gJpT84c2jKs0/7sfY5zgDv
 PMzlUH8o=
X-Gm-Gg: Acq92OFw8GqtnbShPKb+Q7NfzH0QFGcljQjhKJmulcV9yhE/pp401TZEJjUKDCswlC2
 jxhpQUo3xyVjv+WUL52lWZHOzbB8zLoqLGZ2LyDxwhN0u+4f5SsBrDSkrSCARZegam1g3+PVM5C
 nbUMEA0esjbiatilacy0CJSiyKWLoeJeJw3cytk36f8u7wkaHEZ4YDSbFziFRo8B0HOqIwu2IJ3
 uGiwTrna+HZi/wW0+fF94nwtU5H5Q+AvUATcTYu4l3Cp2UEDCaUCvD1KS5APRrtO+bcMRGC230Y
 uO07J9ENibno0iDgjobCQIGop23yPB5ElvKi/dv6TZtepMmQVCNGjg2lowdtZOE27dWpxldWGRN
 eD8yzqG+Y84f+D8rkM/j/Fh06GkrkVmKyq9D8V2WMwPUd0vRAHSliA7oXLBfve6Te0MHxWXvHRh
 D7azISxWKgIlluHY99E7SaIjLeRlsZih0OwFNQIM6TB3rlMMTutRaIC58gGAdc9MXQCQ==
X-Received: by 2002:a05:600c:3052:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-48fcdb421famr22151885e9.10.1778677494618; 
 Wed, 13 May 2026 06:04:54 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d19974sm70145725e9.2.2026.05.13.06.04.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 06:04:54 -0700 (PDT)
Message-ID: <6e28a268-6ec0-4f83-8d31-76c48634c2b0@linaro.org>
Date: Wed, 13 May 2026 15:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Subject: Issue with PyPI when working offline
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi,

This is the second time I'm working offline and do a simple
rebase, which triggers a re-configure, and then I'm stuck because
PyPI tries to access the Internet and do not allow me to neither
build nor test:

$ git rebase origin/master
$ make check-qtest-arm
config-host.mak is out-of-date, running configure
python determined to be '/opt/homebrew/bin/python3'
python version: Python 3.14.3
mkvenv: Creating non-isolated virtual environment at 'pyvenv'
mkvenv: checking for meson>=1.5.0
mkvenv: checking for pycotap>=1.1.0
mkvenv: installing pycotap==1.3.1
mkvenv: checking for qemu.qmp>=0.0.5
mkvenv: checking for setuptools>=44.1.1
mkvenv: checking for wheel>=0.34.2
mkvenv: checking for pip>=20.3.4
mkvenv: installing qemu.qmp==0.0.5, setuptools>=44.1.1, pip>=20.3.4
WARNING: Retrying (Retry(total=4, connect=None, read=None, 
redirect=None, status=None)) after connection broken by 
'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection 
object at 0x105316660>: Failed to establish a new connection: [Errno 8] 
nodename nor servname provided, or not known')': /simple/qemu-qmp/
WARNING: Retrying (Retry(total=3, connect=None, read=None, 
redirect=None, status=None)) after connection broken by 
'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection 
object at 0x1044b60d0>: Failed to establish a new connection: [Errno 8] 
nodename nor servname provided, or not known')': /simple/qemu-qmp/
WARNING: Retrying (Retry(total=2, connect=None, read=None, 
redirect=None, status=None)) after connection broken by 
'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection 
object at 0x1044b6350>: Failed to establish a new connection: [Errno 8] 
nodename nor servname provided, or not known')': /simple/qemu-qmp/
WARNING: Retrying (Retry(total=1, connect=None, read=None, 
redirect=None, status=None)) after connection broken by 
'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection 
object at 0x1044b5310>: Failed to establish a new connection: [Errno 8] 
nodename nor servname provided, or not known')': /simple/qemu-qmp/
WARNING: Retrying (Retry(total=0, connect=None, read=None, 
redirect=None, status=None)) after connection broken by 
'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection 
object at 0x1044b5bd0>: Failed to establish a new connection: [Errno 8] 
nodename nor servname provided, or not known')': /simple/qemu-qmp/
WARNING: Retrying (Retry(total=4, connect=None, read=None, 
redirect=None, status=None)) after connection broken by 
'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection 
object at 0x10537dd10>: Failed to establish a new connection: [Errno 8] 
nodename nor servname provided, or not known')': /simple/setuptools/
WARNING: Retrying (Retry(total=3, connect=None, read=None, 
redirect=None, status=None)) after connection broken by 
'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection 
object at 0x10537de50>: Failed to establish a new connection: [Errno 8] 
nodename nor servname provided, or not known')': /simple/setuptools/
WARNING: Retrying (Retry(total=2, connect=None, read=None, 
redirect=None, status=None)) after connection broken by 
'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection 
object at 0x10537df90>: Failed to establish a new connection: [Errno 8] 
nodename nor servname provided, or not known')': /simple/setuptools/
WARNING: Retrying (Retry(total=1, connect=None, read=None, 
redirect=None, status=None)) after connection broken by 
'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection 
object at 0x10537e0d0>: Failed to establish a new connection: [Errno 8] 
nodename nor servname provided, or not known')': /simple/setuptools/
WARNING: Retrying (Retry(total=0, connect=None, read=None, 
redirect=None, status=None)) after connection broken by 
'NewConnectionError('<pip._vendor.urllib3.connection.HTTPSConnection 
object at 0x10537e210>: Failed to establish a new connection: [Errno 8] 
nodename nor servname provided, or not known')': /simple/setuptools/
ERROR: Could not find a version that satisfies the requirement 
setuptools>=44.1.1 (from versions: none)
ERROR: No matching distribution found for setuptools>=44.1.1

*** Ouch! ***

Could not provide build dependency 'qemu.qmp==0.0.5':
  • Python package 'qemu.qmp' was not found nor installed.
  • No suitable version found in, or failed to install from 
'/Users/philmd/source/qemu/python/wheels'.
  • A suitable version could not be obtained from PyPI.


make: Failed to remake makefile `Makefile.prereqs'.
make: Failed to remake makefile `config-host.mak'.
$

Is there a way to skip that and keep working with the codebase
offline?

Thanks,

Phil.


