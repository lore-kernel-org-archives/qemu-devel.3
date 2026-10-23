Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A2A606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XhO+15Za;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UxwxWZhu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKJXT-0004l1-4j; Fri, 23 Oct 2026 13:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xKJXR-0004jh-5G
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 13:58:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xKJXP-0003gO-6m
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 13:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792778321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=B+8YmqefU8kZnCiVWlYoOwQBX8CQn4TXv3+yjwk5+Qw=;
 b=XhO+15ZagRJMa+trABHh0oWMB9Nqw/7vJFvbuLAYHWj35sCDIH2BGzq9DmKIKHZFZ376T3
 olfIUjARUFIUWRtza6y771Xcgj0bVIRRtDl9qzvZ5MNap1mzykvJD8oYD8xbK5XD+otUGF
 lP89kGD7inO7c1U65CgFjIcFkK0qHvI=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-2Ld-yOv0OTeLqoC9WQfC-A-1; Fri, 23 Oct 2026 13:58:40 -0400
X-MC-Unique: 2Ld-yOv0OTeLqoC9WQfC-A-1
X-Mimecast-MFC-AGG-ID: 2Ld-yOv0OTeLqoC9WQfC-A_1792778319
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-67935d0ddcdso2015265d50.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 10:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792778319; cv=none;
 d=google.com; s=arc-20260327;
 b=GDmBcGtDwJm753rF1DjZYhwUVK1UQSLIpoDrktilARHJXBQx4ZsXlji8N7kUy9gBPy
 x+Z8KTG9L1LMCtL8whLBQ/uDb4KeJ173RvAAIoMfbxipRvs/d1yoDNwiJra8tONkF05O
 6rmkv6QL4u2nfxb04mF0a14SvMcFtij/knSGtYT5jsTV4rZkPT84iczoJ0XAoIvGPdgM
 9fr856GMzMZKGBVulJpRh0BdpQKBxkYi/kaM7teol58SNCm4ftI5hIPpPPt3kpYiDjF3
 kbAK9mPHVinhQgQRSU5HLOuP5BNLEfeRrc86skrT+h1VXpLvCsw2ewkG2zXbryiQq1QG
 X5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=B+8YmqefU8kZnCiVWlYoOwQBX8CQn4TXv3+yjwk5+Qw=;
 fh=mOr/h/F6GPSKOyuIsoYY6zJinMYlGJwjdCpdnBdeOUw=;
 b=TMN9vAnxwr3x2CSijcFjpYTxV8jm8O3WbcVZNKGxC/xjfadBrlY0UjM44qVe0sLFjr
 CqJ8PU2D9NCghmsa6HobixjtL0lVShOjtESHlY1b2xK3Ar/F5KPasAtAMs7rC/y43zVn
 DE6kTBKdZA5XyY4sguGOfFY7+neNV9Uw1MJ4ywTECscXlGQT5YgWvVg2TWgfLyls45o/
 ZiglWHf9NjdExgT7QCKHrP2vEYfmzq/6Rk1ZMWm7w0Xm2p9a6PrpC/nkCLlVDivWTV9i
 BTchJUNRph7BYnZTj5I9GYyZg+k0ihpKEl0gukYBRKejrV50xcsJw2vDEuA0MQIo1YvG
 dOuA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792778319; x=1793383119; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=B+8YmqefU8kZnCiVWlYoOwQBX8CQn4TXv3+yjwk5+Qw=;
 b=UxwxWZhuz5lA9rz6L5wIBhdSZB6+x5QCL9mu0FCaOs8RqbJrxLtC3Sb+qvkDolLU3U
 slQluY9YFZRWIaGobZyUHYjaXjMe6a6LrmnQCuW9P5NHCH0zaHXwlxBFPaz2JROZAQ4b
 E0A2u3mPAD+hs855/gFitrZxKO83NrAqyfvmQd0fTEW9HfS4P4PnCeTA0hByS72b/xkD
 RYUlp8Wubvy1YZ0B/dJTt5/QD3cyh8L4J6Dw3CjWZFvEn2MCwiKqy7s3frCX9QrPQVP0
 hCdj5hoV8/AxDQVYREjoAJNiuExmxQGj9k4X8slzEJJQy+u4n3a102NWBisp5+lgPxvf
 /SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792778319; x=1793383119;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B+8YmqefU8kZnCiVWlYoOwQBX8CQn4TXv3+yjwk5+Qw=;
 b=Ab/6t1bOOOUUrRxJiuYLfI9ZeCcQJByRjT3mIW836AmC3j/ef/yNTO2kMUMDlT8NAl
 lGPsKg+dTFfSYA6/aMoUK5gdcrGIjaUAiZWH4HnP3OUAuYUAiwIB1bXAbh2j66bdPjlu
 itewT9KiJCcGFNfvWZ9hqr78FDEQUao32vsIog/CMdbeopc8EScqmpU/Sp4jMQV7mk6M
 Sdqby2QkfHhW+xCpCL76+/+kH5k/d18cN/+MSocne3WogAx9ulpmRT5otybHUfiXUNVI
 23whQlXoJGZARar88CTxaYn/K31SnTv3rAtkyWQzFhDFF1MF9mzkKgqvGFBuMIwwGwSz
 loWg==
X-Gm-Message-State: AFq9FYJJEsWHLSImi3T88mN3V3TTypJvfJ4lVaFYaPgudc6J8iUWwfzL
 HS8bI17PSVhPZW/n4peOr7IRDB9hkELJ/jbonxQhPyrmhBM8TnWIQV1j1mJao1k/oBzoVNcbnQj
 u3mWk/D7w4azEEjvRrQdfzcHX1pgzZa4xHkj2R6NoUWIqZoD6MjLDoFs61Wi2kBayrI4VbfJSji
 cxkPqbBbJv79w/scyGUMpyVaO8tgpcdWakN71i6jwldQ==
X-Gm-Gg: AYBFou3+F8U8NOJxmE7UkzJ3bqbt1yT3ZZ60lhfbVW6LiVp3vfVVuFaYPs7+W+8l6QY
 V0GLSA57gPR4duhgGhfd6LPRlVT8moS3Gx+dKPlFEs9jni0HfFwLdjWb+3wOdMvZwBMa/0nQF67
 RQgDXRSScq7qIOtrkS6upqOqyALDlwpK1wXVSBlG7QiKJZbRSCESG5uQIwOY5kKL2UvMdVfBKhZ
 6bgmH39U1dbplLE
X-Received: by 2002:a05:690e:12cf:b0:679:a925:edf2 with SMTP id
 956f58d0204a3-67a35bb9bd5mr2039970d50.19.1792778319282; 
 Fri, 23 Oct 2026 10:58:39 -0700 (PDT)
X-Received: by 2002:a05:690e:12cf:b0:679:a925:edf2 with SMTP id
 956f58d0204a3-67a35bb9bd5mr2039959d50.19.1792778318755; Fri, 23 Oct 2026
 10:58:38 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: John Snow <jsnow@redhat.com>
Date: Fri, 23 Oct 2026 13:58:27 -0400
X-Gm-Features: AclHuK_uLNiUcv4b3HNSMP0gQsrggffbIt25Z3RZsCVRlH6Md9D8H7PWt7jn8XE
Message-ID: <CAFn=p-akuS92BA+Oza7ZHHiUTgN47_B_XGqCGik=_wHR==ff9A@mail.gmail.com>
Subject: [SECURITY] Python and eMudhra certificates
To: qemu-devel <qemu-devel@nongnu.org>,
 QEMU Security <qemu-security@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello all, a note from your resident Python maintainer here.

Concerning the recent eMudhra leaked certificates and the impact this
has on Python tooling:
https://discuss.python.org/t/information-for-python-users-regarding-emudhra-emsign-ca-certificate-security-incident/109576

QEMU does not bundle Python, pip, or certifi and there are no remedial
actions to take for the QEMU codebase at this time. QEMU, whenever
possible, uses your host system's Python stack and packages. However,
if your host OS or Python environment is using compromised
certificates, you may be exposed to MITM risk when running `configure`
without the optional `--disable-download` flag as part of building
QEMU.

The issue is that `pip` may be using bundled, compromised
certificates. If downloads are not disabled, configure (via mkvenv.py)
attempts to fetch missing packages from PyPI. This may expose you to
an MITM attack.

If you are confident your system has been patched, no further action
is required. If you are unsure, below are some tips to see if your
system needs patching. Until you are satisfied that your host system
is correctly patched, be advised to use `../configure
--disable-download`.

A simple test to see if your host environment is impacted is to run
the following command:

`python3 -m pip install --index-url
https://dv-g3b-emudhra.we-have-a-problem.com --dry-run pip`

This should report an SSLCertVerificationError. If so, you are all
set. If not, update your tooling to remove the bundled certificate.
You may need to patch Python (to upgrade ensurepip), pip (which
bundles certifi), or certifi itself.

Keep in mind that your host system may have multiple Python
ecosystems, and QEMU does not necessarily choose the "default" one in
the absence of explicit configuration. You can force QEMU to use a
known-safe Python by passing `--python=/path/to/good/python3` to
configure or by setting the PYTHON env var.

Currently, if neither `--python=PYTHON` nor the PYTHON env var are
set, upstream QEMU will attempt to use the following Python binaries
if they are in your $PATH: "python3 python python3.14 python3.13
python3.12"

To see which one your build environment is using, you can safely run e.g.:

$ ../configure --disable-download

and look for these lines at the very start of the configure output:

> python determined to be '/usr/bin/python3'
> python version: Python 3.14.7

This is the version you should ensure is correctly patched before
allowing online downloads of missing Python dependencies from PyPI
again.

You may test each Python version installed on your system by
explicitly invoking the test command with different Python binaries,
e.g.

> `/usr/bin/python3.15 -m pip install --index-url https://dv-g3b-emudhra.we-have-a-problem.com --dry-run pip`
> `/usr/bin/python3.14 -m pip install --index-url https://dv-g3b-emudhra.we-have-a-problem.com --dry-run pip`

and so on.

Thanks,
--js


