Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0BC606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AAmf1Rzt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWxBW-0006A7-3j; Fri, 27 Nov 2026 09:44:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWxBU-00069u-Rd
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:44:20 -0500
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWxBS-0002RQ-SP
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:44:20 -0500
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-67c24619b19so6936996d50.2
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 06:44:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795790657; cv=none;
 d=google.com; s=arc-20260327;
 b=K6/azgiK9ZzppQRGfiG9Mll1VdC/w6Fzsc+NIAhd51xslWlHQrFCB+g0K4A+UZ/bxp
 Y8XHacueyFGI9A2xDP5oVVM1xdRDgnUChuj0bnX7zgTd9w54g7Lt/oguq9s/q9OvnEWY
 Wbm/DIn/Us0BDxNYZz/G5E/zsnr2MQr1FtESJlEkUmkZHfr9EoO5vzHTOlHTDfu2AJCY
 npKFPAOrSS/6XpPBgTJpmqdK6O5lsiVviWr4yOYN8+Yjy4+zha5hWWM95C1a+HHvGv6n
 sDbg6F/CspV+xySEDhHb46uayAHle9QPF7+KrIuZGOHBY2PDZ/z+ldQbzGvEwv5CjslS
 AVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RxRjQA+e9SZaEZsMwWOxcziyDarrSmbGDGI2zcbfP44=;
 fh=pTXkZH/fcO7vJfNEepqKhH6vNF2iCXqlLRsUxvEZY+c=;
 b=S75MpqZfs3wtnoe4E4Q0/WP+xKqdtSZvyZjY+/YGxDTTxxJOobzasKsvG+6e8ZUhpU
 LOWgJx+MGfJ5KCbkTiTkmKiGR2NMw50KBKRXjvc9JJ8HVNc/ylS40q+jkSlJidgL4jWJ
 0mFutHMJMTUSu0zWfAnxEx5I5iU+B0bD69M74X9eKIe057J7FY9EMN+weL9yXNZ6OO9/
 DMcYiNlxQVOvkF1KRIX2owaDBleuhJ3fJrzgxixS+Cqgb8YQxTGdEwn4dHDInD05O63E
 X1x0xPnX48ITZ9ukq913hHV660hp8UElW7xdoaaudOubkKNPWysTKLPxIG2ZD5b25mjC
 bWFg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795790657; x=1796395457; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RxRjQA+e9SZaEZsMwWOxcziyDarrSmbGDGI2zcbfP44=;
 b=AAmf1Rzt8Np3d5vE8HVkKvCP/5qdVOWpWH4hNtojg6zGhFvkL3sRPDNHwSFfTDm0Un
 pQduxx7zscvamxLxBPknkvTB7xwN8cMD7JbqvwsTOa0QacJXa37w+0r6ge4ydjYzjIGv
 fudFjagaQCUJ5wl0sw7NN7Onwzs0LHIlzT5qiaOVp9Jtn5N9zjU56l0qAfWx1NZXm4Zg
 J6aNrcFKRw8FSYGhRf4EmpmpP/0C50bbrvX069qNiCSJhv/1hcgUU5jyRsE+ITVmVjr7
 Pwt+OiUPiB8PORao/bcjlVi4RHPWa/VidPkYw6wPgyyLGnfzP2EU4IUxvV3yJKS8YdQ3
 H6RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795790657; x=1796395457;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=RxRjQA+e9SZaEZsMwWOxcziyDarrSmbGDGI2zcbfP44=;
 b=D12rn6zvu3Td6Vi2QpkXQ6Zh22dvQHDK7wjLtb2CIKUG5IHkx7qFW06ozQa3/sL9dn
 S6smyK+Oi9THKBXwgk1KoL9HPjj+1AcAiTqpt+9/zETORPGavffiuGxHwI9mEeVp4JOx
 U0Q/siq4joH52hEMdv4tZi+pUaemi19+Hru5zFmBC8BFBLfLKZYy58cY6HPqk58d1Ab9
 nwbmZDIk7mAXpzs3BiooWxLfYSoj+e9p1XDul9to/oWiKUjhlizJ6JT4csD+mekludBP
 qCap+/XXrziV/OYk1HUCZsrliMQAbyv8tE5YaQr8yuSI1G1P7170lVeIckCi5yfyjsIP
 nmtQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFcMX402ZKSql1vB1afVeXkN9hwXzIy8+gcoQtlZEhnjrXau7zpOtuW8VYis703euewq2DUTvYrwQtJ@nongnu.org
X-Gm-Message-State: APuU4Z+Tb/fx1Czus5RQxFvPwPUq4dAHOWOyazouCLhnhB8PcyLK6HEY
 WB7U7C6tQ+49pX+lCnm4h0Rxgt+x4KAB78SDfQsYQRpE88mLUWW0E+/D13XzS6Uv4xTHMwioomn
 zSiel7QjdL187e1H8lC8pYA8iZze26Sp2gqcHWcGPng==
X-Gm-Gg: AZFdTZch9k9ZSge/y1NzEOdhdoqiNNaxDRrk/T+/8VlB/t1FfvlYE9joL/NNpzg2HVM
 o7XmIOlAD8mUuGI8xA6uDtrXmfJrwB+nXu0AhQY9z471p3QRzillI2KBKPzvAZKQF3BPCmdt0JB
 HjEtVnlpULZUBVfaEfsRyrKaVfQwY3yIc6+KzEjQBKVBH3D/rxX/C69o2/x+2IwH3ktDSz8rufn
 aJVzkvg7PifcKjE1fTnJBa00/VipsE9gyWhFuAyNqZx39b0GfPvEVdZSGPn3EHFPg24TjXm86Dl
 MTCo9uEV+eySyMYwconck5gIhOHKKwBTQC6MZDJ01R2WTw5ZXX5gNci9CMzcknfFuD0u9qJtiAl
 A3zzSKpGcDSJnbrZcjeax//u+4DI99fNxxfg8tdmrNNGcsM5v5QNZmjoxwkQ91KWkXzY/RHXYV+
 UETTs9GctCi/TFdmrZYU4o
X-Received: by 2002:a05:690e:4806:b0:67d:b898:4b27 with SMTP id
 956f58d0204a3-67df42c45d3mr6990242d50.9.1795790657029; Fri, 27 Nov 2026
 06:44:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261126231631.3392756-1-peterx@redhat.com>
 <20261126231631.3392756-8-peterx@redhat.com>
 <87se0mquhh.fsf@suse.de> <awmR_TMQd9c8gxhd@zhexu-thinkpadt14gen5.rmtcaon.csb>
In-Reply-To: <awmR_TMQd9c8gxhd@zhexu-thinkpadt14gen5.rmtcaon.csb>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 14:44:05 +0000
X-Gm-Features: Aa3M54ooDQV9v3DLedryZ1WZP9BwIqkcmllIdL9GN7YyHGoS7NW1ZRLYofvROQQ
Message-ID: <CAFEAcA-d2Das=U+da6W2j2RPR48zf4yxO2k8-SCdwDPMvF_C4w@mail.gmail.com>
Subject: Re: [PATCH for-12.0 v2 7/9] arm/machine: Convert cpu_post_load() to
 take Error**
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org, 
 Juraj Marcin <jmarcin@redhat.com>, Gavin Shan <gshan@redhat.com>, 
 Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 27 Nov 2026 at 14:23, Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Nov 27, 2026 at 10:22:50AM -0300, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> >
> > > Convert it to post_load_errp() version, so as to be able to report verbose
> > > errors when hit.
> > >
> > > A few things to mention:
> > >
> > > - The old "fail" count won't work with Error**, switch to fail and return
> > >   immediately, assuming we should stop migration immediately hitting the
> > >   1st error.
> > >
> >
> > You could keep the handle_cpreg* untouched and just create a new generic
> > Error when fail > 0 like you did for !kvm_arm_cpu_post_load() and
> > !write_list_to_cpustate(), no? That way we don't lose the reporting of
> > the other bugged registers.
>
> I can, but I thought it was good cleaning up those error_report()s.  I'll
> see if PeterM has any preference on that.

This is largely Eric's code (cc'd).

-- PMM

