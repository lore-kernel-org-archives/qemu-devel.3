Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B63C021B8
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Mar 2025 07:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toHGD-0003Q5-T2; Sat, 01 Mar 2025 02:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1toHG1-0003I8-58
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 02:27:33 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1toHFw-0003kH-D9
 for qemu-devel@nongnu.org; Sat, 01 Mar 2025 02:27:31 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-abbac134a19so433286266b.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 23:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740814046; x=1741418846; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kznBvEZS8TAhjlcspBRTuZNGp+f6wNiPImDFbVcPVM8=;
 b=DSURpBhSBuSoPuIafxlmU7opG563F7Ce+Ytn7ZqAIjJr+IHHksCZ05dtlyJ/84/xUi
 h1D9dgD0piPeFxlWguiqToI9SfUcM1CokWoBmln4HA6BsPa0GxrPo69ra5Fzy9xE+3eC
 g7yvI7MCmKB9UStzpKXOdVPbiB2Og/9fJvQXjUokui2cUYqYrAkCgihp/MkmcwTp5uJl
 LpetBxclOuAvdRWH9lPRj4pesg9k342j2AdRYUWeay6B9Lo+tNbQPaI94gbhxo+Gcfhx
 Saq0xpuh1xSoyS736FCwl5LvY9B05ZWP2e0OROAagmzFaEKUJdBlu3+SiMydZw/uNIyY
 v8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740814046; x=1741418846;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kznBvEZS8TAhjlcspBRTuZNGp+f6wNiPImDFbVcPVM8=;
 b=W8Spjfy28G9KhBqbjeOEZAhyP/EV6qW9NifiLeWvWVjfivema8v2n6U1zTI+f+95GS
 5988n7GG5rrOKAWlyRIUP/wV0LIPg9+VZn8c/wLNokshV5OOh0a2lLHVP3dM5d+UEkPr
 uAZFfqrUFK58gn57h8z3pCEHdVYbz3GR+SnF/upbfE+lDbgGpFFQWl0PqeRuXdLysIua
 UqGT+SMSQVWxzk2LFsIk5px/gglheqgP9I4aJejQr6g4D+K7jKyXzXBrtq34eu6OgNiJ
 cYRrejsY6PQ+jq9yhDnziex/Oa4+m+OTf5/kGa2frjiULKwXB2nyNcQJX89TKD2V6k47
 4+1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/oqBqqKrxTuQgyUhUe89XoRaPQmpq5jNxJUC/S6lppvConHGmIeoXzZXFA6KxqCUIIw4h0z5kJ+iv@nongnu.org
X-Gm-Message-State: AOJu0YxjQm5sRMZ1E5RK28k3gwly2H+PDZmkvJ/mqVCZb6mAt2vAzK8U
 fyzk8qcNNQMc4y2nTQBkMo+6wFBySmH920XqMVq7GR34p0AOt5vuyq+Pg3J5wnDLvtRnLOdFlcE
 2Ly07Koqbzyqj+CHJ/YbLaPL/xBo=
X-Gm-Gg: ASbGncttE8Y6VL2IgvZh5ZdoP4cI7gx4vZkNKk0QJ20GH16JyFypR50TIhtaDEgf8lV
 3HKYHxZmSWCQa37yqB4QjXNFBR9M+GHwgW5w40gi+GKOBpoMSt2ZDa3wqTdeyWv/XTHf6xSlbWr
 mXTc0hH7dl/AP4JoOB98TOVH7n4w==
X-Google-Smtp-Source: AGHT+IE1+cpunXLK8q4VPVUHGhdySGKY8m9IstniT9kqAagY16NSRA7cyHLa7L4k8cKqlkvYOpbj2p8u4IKANAVM1pA=
X-Received: by 2002:a17:907:6d16:b0:ab7:6c4a:6a74 with SMTP id
 a640c23a62f3a-abf25fb8399mr702772166b.16.1740814046176; Fri, 28 Feb 2025
 23:27:26 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QUk77GViTBgBpfYH-AbAmQ5aUwi0K6UTH9iv=1mVb0Wbw@mail.gmail.com>
 <803732f6-6ab1-4298-a956-660496664f67@redhat.com>
In-Reply-To: <803732f6-6ab1-4298-a956-660496664f67@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 1 Mar 2025 15:27:14 +0800
X-Gm-Features: AQ5f1JpZZZYqPw_wifX5HUapdmxckoBCTwxU6rOVRbOKmaPy_sjPov1yJNeRU9g
Message-ID: <CAJSP0QW+uthupzD9_d5pav6WsB50MTH+MUgBaRYE9LfbORA-ug@mail.gmail.com>
Subject: Re: Kubernetes gitlab-runner jobs cannot be scheduled
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Camilla Conte <cconte@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Sat, Mar 1, 2025 at 2:36=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>
> On 3/1/25 07:19, Stefan Hajnoczi wrote:
> > Hi,
> > On February 26th GitLab CI started failing many jobs because they
> > could not be scheduled. I've been unable to merge pull requests
> > because the CI is not working.
> >
> > Here is an example failed job:
> > https://gitlab.com/qemu-project/qemu/-/jobs/9281757413
>
> Hi Stefan,
>
> until February 26th the Digital Ocean runners were not enabled; I tried
> enabling them (which is what caused the issue) to start gauging how much
> credit we would need to be able to move from Azure to DO for CI.  I
> posted a note on IRC, I'm sorry if you missed that.
>
> > The cache PVC appears to be a manual addition made to the running
> > cluster but not committed to qemu.git. I don't understand why the
> > problems only started surfacing now. Maybe a recent .gitlab-ci.d/
> > change changed how the timeout behaves or maybe the gitlab-runner
> > configuration that enables the cache PVC simply wasn't picked up by
> > the gitlab-runner Pod until February 26th?
>
> Almost: the cache is not used on Azure, which is why it works.
>
> > In the short term I made a manual edit to the ConfigMap removing
> > gitlab-cache-pvc (but I didn't delete the PVC resource itself). Jobs
> > are at least running now, although they may take longer due to the
> > lack of cache.
>
> Ok, thanks for debugging that.  I think what you did is right, and the
> caching setup should be tested more on a secondary cluster.

Glad the change is acceptable and didn't break things more.

> (As to the DO credits numbers, the cost of the k8s cluster is about
> $75/month, and since we were granted $2000 in credits we have only
> $1100/year to spend on the actual jobs.  The plan is to check on the
> credits left at the end of March and bring our estimates to DO's open
> source program manager).

This reminds me I received an email asking for feedback regarding
QEMU's Amazon credits. Just wanted to mention they are there if we
need them.

Stefan

