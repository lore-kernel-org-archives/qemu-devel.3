Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370F0606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.de header.i=deller@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=MDfOKhFL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUAZA-0000jE-HH; Thu, 19 Nov 2026 17:25:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xUAZ8-0000i3-Lx
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:25:14 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xUAZ6-0007GM-Bl
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 17:25:14 -0500
DKIM2-Signature: i=1; m=1; t=1795127109; mf=PGRlbGxlckBnbXguZGU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=; d=gmx.de;
 s=s31663417:rsa-sha256:azmkqinK0SiPr6n/o4PImRK3jqnA
 z0VdkGeJN9oo46D8Hae/XhZCSgAKFwsOogWTndUhcM7bdWpqRD2H0JFfQGUh/he3sF/4OysoFfd
 x5Hsf5IlklmivNpvYtX0U/lq2D8U6cf7ol3GSlCYGAIcqWON7UE+m0nepUXWKpnuWoTDXusmo5Q
 8uCU0pd4eZeOGBiqJYgtpeAYh7Pc2bXG653M0MmEUAxIYidJ1VIAhyweSxTmD5C8wNGL1qAsR60
 VPIfFWSWHweStETNqeatkkrcByK2ocd+6xRrRYg/o5LxOVH2wJ4c7MJharM7oQgVgcsf0gbIcXH
 19QBui8q1x5YFw==;
Message-Instance: m=1; h=sha256: GeoHB0fRFoAJgJgvIQ5pbVDssMK0jXW7MI+PJFSxCQg=:
 qoNgaUcU+TciJVQa7jpZ6PQ6JLUP8rvoJ9IlhPssWnE=, sha512:
 +WusByqyKIG3c81BCQLmDpS8dl3efU2lOLduoWG3lG2BBX76c9bFD9NmfEfkmS/8djQ+aOWpCpXh8EBgvdejMA==:
 0w3UmMhA2ehxMa4ixP+VZEhp8ZvoxZtD9nlBQ+ZCuXJoihI5ggjhEBPGNl9QRD6anNDtb/6G20+KEfl67BqETw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1795127109; x=1795731909; i=deller@gmx.de;
 bh=vNUOctY4yfkWZkEkgBKJOkRY08D/+zY2HEbXmQzjQfo=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
 Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=MDfOKhFL56+W9Lib7EClRzoo6eHG+FjgVQhvxrak+Lj4VLQp/XjcuMhKdyCOFpUt
 bg1zl4O8AaiXhlXtM6LPbJx/RrrqNL3po5oIkxPqc2plqK3290vQYfpI+qOxRBX9U
 LGg1ut6aisFPEgtzyVcpKvfBWT4C4LMzGjfTDy1SrU13l5PuHN0uHkOK7gr90AOaJ
 sqnJKoaXaiYCS83YS6xtM9k0EUqrM8ZFN8YOCQWuwglzL33ytkbjLtwVGVk5kZl5t
 zZP2eIxFpKcaRzfnBIeBk/VowncZvcS3J8L1dln/Th9n3EX7SIflARUjcuhOqqHoF
 E0fQ/FZmyqWnnp4VRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRCOK-1x6yqf1utg-00MUF5; Thu, 19
 Nov 2026 23:25:09 +0100
Message-ID: <f1471b2e-fcff-40a5-9bf8-077d3294cf6e@gmx.de>
Date: Thu, 19 Nov 2026 23:25:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: qemu-devel@nongnu.org
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Subject: rust build dependency ?
Autocrypt: addr=deller@gmx.de; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:+LFrQhw1r5INF/kWAySC9jLYhZGS65VrLIKef0yWEIPINRq7XDv
 UjahutBpUUg2KcYM03TvCSnvWvVXpLzKokt8OWTFqnpgsRJuLqE2zfEATf9I0ccoZQZR5FC
 ghODxE/zsaXAjhZ1taDllDELB4z7RkK3L9FFFl+Am2eew/DwuBLNgsZlT3HKQM6Cy6TZdq3
 blWYFLz6MK4ySAp0w3s2w==
UI-OutboundReport: notjunk:1;M01:P0:USr+QvphI3g=;9Yh2rfVrQcenVsk+tRNo6q5QC26
 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
 ik7OwNolJStUf23qHzI2ria
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With git head, I'm suddenly facing a dependency on rust, which wasn't the case before.
Am I doing something wrong, or was it somehow just added? I'm on Fedora 42.

deller@p100:/home/cvs/qemu/qemu-build$ make
/home/cvs/qemu/qemu-build/pyvenv/bin/meson introspect --buildoptions /home/cvs/qemu/qemu/meson.build | /home/cvs/qemu/qemu-build/pyvenv/bin/python3 -B \
   scripts/meson-buildoptions.py > /home/cvs/qemu/qemu/scripts/meson-buildoptions.sh.tmp && mv /home/cvs/qemu/qemu/scripts/meson-buildoptions.sh.tmp /home/cvs/qemu/qemu/scripts/meson-buildoptions.sh
Failure in scripts/meson-buildoptions.py parsing stdin as json

../qemu/meson.build:96:12: ERROR: Unknown compiler(s): [['rustc']]
The following exception(s) were encountered:
Running `rustc --version` gave "[Errno 2] No such file or directory: 'rustc'"

make: *** [Makefile:134: /home/cvs/qemu/qemu/scripts/meson-buildoptions.sh] Error 1

