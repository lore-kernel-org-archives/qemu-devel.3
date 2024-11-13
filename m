Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE8ED637A4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 18:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBIDI-0000fI-Hz; Wed, 13 Nov 2024 13:35:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1tBIDG-0000ep-7P
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:35:34 -0500
Received: from esa12.hc2706-39.iphmx.com ([216.71.137.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1tBIDE-0003vb-Ap
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:35:33 -0500
X-CSE-ConnectionGUID: wP0h/wmATpawaPr8E1pn2Q==
X-CSE-MsgGUID: YvCEk6BPRu2+XWbgZwI4Eg==
X-IronPort-RemoteIP: 209.85.222.199
X-IronPort-MID: 2561428
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:mWBiOqAgfa8f8BVW/2Hiw5YqxClBgxIJ4kV8jS/XYbTApD931mQPn
 zNNWWzXO/2JN2P8KY90aN+/8UMEv8DQzd5rTANkpHpgcSl2pJueD7x1DKtR0wB+jCHnZBg6h
 ynLQoCYdKjYdleF+1HwdOGn9SQhvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYctitWia++3k
 YqaT/b3Zhn8gVaYDkpOs/jf8Uo256yo0N8llgdWic5j7Qe2e0Y9Ucp3yZGZdxPQXoRSF+imc
 OfPpJnR1n/Z5RokFuS+mb/9dEAQKpaKVeRZoiMLM0QKqkEqSh0ai87XBtJFAatko2zhc+RK9
 Tl4ncfYpTHFn0H7sL91vxFwS0mSNEDdkVPNCSHXXce7liUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwNwhVblecgsuK2LukQ9F21ul6NM+xBdZK0p1g5Wmx4fcORJnCR+DT5oYd0m5h14ZBGvHRY
 8dfYj1qBPjCS0cXaxFHVdRkxr3u3yiuG9FbgAv9Sa4f6mzDygBr+LLwdtfZZ7RmQO0PwxjB+
 jiWl4j/KiAEH/GclxC9yG/2xd/wlyzJR6NOObLto5aGh3XWnAT/EiY+TFa+vLy1h1CzX/pZL
 Eob/DdoqrI9nHFHVfH4Vhy85WeH51sSAosBVeI97w6Jx+zf5APx6nU4cwOtoecO7KceLQHGH
 HfZxbsF2RQHXGWpdE+g
IronPort-HdrOrdr: A9a23:NOkt26Hxkd7pMCvZpLqEGceALOsnbusQ8zAXPo5KOHpom+ij5r
 yTdZUgpGLJYVMqMk3I9urwXZVoLUmskaKdpLNhQotKPzOWwldATrsSlbcKqgeIc0aOlNK1l5
 0QCJSWYOeAbmSS5vyKmTVQfexQp+WvweSDqd2b4U1QbTxHXYld0iYRMHfkLmRGACZBHoQwD5
 eR645qoDC6aW0LYsnTPBU4tiv4yOEjVqiKXffLPX8aAcC141OV1II=
X-Talos-CUID: =?us-ascii?q?9a23=3ADtF8kmv/J2zQuDBkPUIQN34i6Is6SiXdi2jVCnO?=
 =?us-ascii?q?gAHlgcKfFZAaI/vldxp8=3D?=
X-Talos-MUID: 9a23:d+4TPgaCdfMO5+BThiHHqTI8Hv9S/v7tOH8HnqcZmpWpOnkl
Received: from mail-qk1-f199.google.com ([209.85.222.199])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 13 Nov 2024 13:34:58 -0500
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b147855414so1015368585a.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 10:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1731522897; x=1732127697; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oK+r5qF9DP1PhwgHiMFOxEQv474qAVWAIM3ap9bB9Tk=;
 b=B61aFHHoZUJ/NGUJaNTqnBxEN05wvvFbXjAQK6Hzp2X50hOgswcDJNn48QE5JSd3VT
 gd8kKX8qjMdMj283m9VH3ueF1YxR38on1/Otc0AuCPncEuZXPYtGkieTT1/BUDYxOUdW
 9cszHHJFoK3sxhgb2z7mnSUo6zVxlrYclBKquNlAhn3dMe+YCirvBsXT3Cy3ve1MV94K
 tOm18wKbJoVAllJRMnV397bqnJ2jeF/gb4KQUZ80yyqgxkgSOwZ1bePzyM3fl+eRuZte
 TN/2HCSIGp1ucipRuQZ9guJX1UoMuO/G9yPq+YVcIJnNNZjbHYLEuCVKhDzCfWu6odic
 yEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731522897; x=1732127697;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oK+r5qF9DP1PhwgHiMFOxEQv474qAVWAIM3ap9bB9Tk=;
 b=OYJqDOXOo6O25Cl9BkO/RTNh92JmdRIS7Q6/r9Jm4cq+cXGqqBlBtFh3egl8cz5dWA
 Kq5ps55F2tnloM0mD7D5iVDsXsIy8pG8TpbhoY0CrywXrzURrTb8nMcHo0NTGl42gsP6
 T59B9wNsSpvPFO9iOPVcLFk/ilOHza/UmeowRlmhvWaDMB4ovYGtbIu7jElaEpSBtnWZ
 AaX2+rjB+9x1yprBCBBcNxvr840gIrFKbavKN6bWVgO9VI3o1+JilM6XZWUeOk4S099m
 8VoBu3adSSAjQ2Iu5l79+CdzbGbDpbJULML99HriXRQEMA+Nsduxo4VxFGZJmCXPuPql
 cDRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxGOhVTaXcVmkWWU8JZyDEKlM2BB2WAvXsBKD7qeq8bYgxxzXvMnTgJ8dnfLHXbYaVzCAOwdWHuntR@nongnu.org
X-Gm-Message-State: AOJu0YzkA3H8hoXjJ1U5EhR+hOUedyWhNnJbiHQmf8w+WcjcOlvg5wH9
 HQ31QyZe/qUAD8XUo0Bhdix5kqTu8f+l8ZBmGjHPMSaGkZkxspLIngHIj6ccO0I//7E1vTQuHoi
 bwXxvQBSy4Sllehi81B9woRY3v8YWBIOgD1ujaNvfCB2LG0Vc/8hO2i8h0N1dgIIsQQ==
X-Received: by 2002:a05:620a:4047:b0:7a1:e4e4:3a9e with SMTP id
 af79cd13be357-7b34bb17b3bmr958907885a.21.1731522897052; 
 Wed, 13 Nov 2024 10:34:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEOxMDrnMU3JDYwcgGlIcApF6AQEdO9+JhJNamy+pok002W/TCJragHk1rAgrK+0wzZ8OJ3Q==
X-Received: by 2002:a05:620a:4047:b0:7a1:e4e4:3a9e with SMTP id
 af79cd13be357-7b34bb17b3bmr958905685a.21.1731522896758; 
 Wed, 13 Nov 2024 10:34:56 -0800 (PST)
Received: from bos-mail01.vrmnet (pool-173-48-150-109.bstnma.fios.verizon.net.
 [173.48.150.109]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32ac43811sm720157285a.35.2024.11.13.10.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 10:34:56 -0800 (PST)
Date: Wed, 13 Nov 2024 13:34:52 -0500
From: Alexander Bulekov <alxndr@bu.edu>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Darren Kenny <darren.kenny@oracle.com>, 
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH] fuzz: disable tcg for OSS-Fuzz builds
Message-ID: <xydqdaplcewxtjoz4r47zxfxospoa36vrmpmicm24wilkmdueh@x5qtvnty3nln>
References: <20241113163800.355547-1-alxndr@bu.edu>
 <CABgObfZsesHr7gr8CVgW471hBkW6E5rfhpgtBTuM5owuPazPNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfZsesHr7gr8CVgW471hBkW6E5rfhpgtBTuM5owuPazPNw@mail.gmail.com>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.137.82; envelope-from=alxndr@bu.edu;
 helo=esa12.hc2706-39.iphmx.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.054,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 241113 1928, Paolo Bonzini wrote:
> On Wed, Nov 13, 2024 at 5:38???PM Alexander Bulekov <alxndr@bu.edu> wrote:
> >
> > OSS-Fuzz builds have been failing due to some strange issues that seem
> > to be related to color codes from libffi:
> > https://oss-fuzz-build-logs.storage.googleapis.com/log-8d5435ee-1677-40af-9656-b4162fa881e1.txt
> 
> Hmm... unqueuing this :)
> 
> In this log, the error happens even before QEMU starts to build. It's
> glib that is being built here, and it's failing because apparently the
> compiler does not support -fcolor-diagnostics.
> 
> I can't exclude that the same error would happen with QEMU, but this
> patch won't help this particular log.
> 
> Where is the Dockerfile that's being used?

https://github.com/google/oss-fuzz/blob/master/projects/qemu/Dockerfile

Thanks for catching that... I will try to run the docker build locally.
Probably makes sense to mimick what the glib people are doing:
https://github.com/google/oss-fuzz/tree/30da5abe5cd004e8a2f8c92923375d43b4d8a5c7/projects/glib
Their builds aren't failing. (I do still think it makes sense to build
w/o tcg to reduce the fuzzing binary size).

> 
> Paolo
> 

