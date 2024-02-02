Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC98C48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqOI-0006jx-U7; Fri, 02 Feb 2024 05:03:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqOF-0006ep-8p
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:03:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqOC-0008Tw-EN
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706868195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ApeOlPjA/gV1IymHpVxYknzmCgTofJ28lP822LdY4Q=;
 b=SHxHMRduBfPAh4SNja29248DnMuw1GYJVcJYQKJJ5lrPqqElxlbfcDW+EfqeElQEGesGwH
 hn5UmmUF0bQyAAJ8tN91SZZhR/6DD2hrLVSbvgDDJB8M2uiE/uFi1GGVIrxidg6cwo6XRA
 ZG5AYFVTx+PFemQHsXNRyzP/zsAgkzQ=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-b5WR1vKSObuglV1HcbECnA-1; Fri, 02 Feb 2024 05:03:13 -0500
X-MC-Unique: b5WR1vKSObuglV1HcbECnA-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-6da5a9defd5so617572b3a.0
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 02:03:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706868193; x=1707472993;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ApeOlPjA/gV1IymHpVxYknzmCgTofJ28lP822LdY4Q=;
 b=fMDBSqjePfa9zd9CDHo0zWCKtvy1K4C89ultis8+BcGp2m41rOHdStUDG1uPFZWrlq
 fvI6aaqvl30ELScKRsiKtXan6II6WXxEHcCysJybab7LbH6njoAhbF9Tui3ML2BhfLTI
 xTiYUeBRMOvAcUKRPWHoG2CMGHeSnc5RWJEqnw5ybHk5KZTmIvn8Ir7kz6oZv43DpM6x
 SyZ/7A7jipexnZnid2/jsLh2L36OrZ09M+s6FoqxQZc2hWeLDqtpoBI9OksfP5rEJ6Jk
 m9mVZuvhnt4zBxJ4ZiatMspPmNJI12l9tU+A2u+gFAjB17+WkS4AJawZ8ZZRpetTE5jW
 ulxw==
X-Gm-Message-State: AOJu0Yys/LxenPY32uu1+AEUEGPS/uff3FW7uJrJk0ag7OMZVBT7K5SU
 ez/XkUoazuXfCUwFUpht8rmRXghZJ/EugvA/oeW4D0xpvY7ke0kwYEYBnDRhpqKZgzL9MCTonaR
 SZeW+KyDfqR7TvrZai8sfMA5vqVQ3Aaxyfp5ZU4QfcLOaZqLsNO4l
X-Received: by 2002:aa7:9992:0:b0:6dd:c64c:10be with SMTP id
 k18-20020aa79992000000b006ddc64c10bemr5525911pfh.0.1706868192903; 
 Fri, 02 Feb 2024 02:03:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMhy9qbl7zHKYQlzO99X7iCVCfalX8JY5FtiXWrqz28m+hGIzwpeBnwYSKJ16YyudcqxM5Bw==
X-Received: by 2002:aa7:9992:0:b0:6dd:c64c:10be with SMTP id
 k18-20020aa79992000000b006ddc64c10bemr5525896pfh.0.1706868192560; 
 Fri, 02 Feb 2024 02:03:12 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWk1NKGcyGKChinQE9bG2EhXtbIBWbL4WYP5dWX5HjwK9Cd/C/+yod9dstOVUA9KtTmuXvfExsdFPSL9uJF49o4ZATVZqKZY8m3HLAjQJCaHngZnEvw/IiV0PEigOVEgR3MkRzxHQFOv/Spy4SKVu4v2t7Wr6UarYppe3K+5TKJ5uGIlcImxpiLHEmY53566MBSgatNOXgXfTNtjIPuwRbVq7CeZBAYIy4=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 k11-20020aa79d0b000000b006dde36aaae7sm1203208pfp.64.2024.02.02.02.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 02:03:12 -0800 (PST)
Date: Fri, 2 Feb 2024 18:03:04 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: Shivam Kumar <shivam.kumar1@nutanix.com>,
 "farosas@suse.de" <farosas@suse.de>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "bryan.zhang@bytedance.com" <bryan.zhang@bytedance.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [External] Re: [PATCH v3 13/20] migration/multifd: Prepare to
 introduce DSA acceleration on the multifd path.
Message-ID: <Zby92DfN6a7NWgvu@x1n>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-14-hao.xiang@bytedance.com>
 <DE3242A8-37B9-4825-BA5E-15A69964D862@nutanix.com>
 <CAAYibXjRaqPaTiPPL0AhK4BP2acOYJE1sr38G12saQwrZuihZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAYibXjRaqPaTiPPL0AhK4BP2acOYJE1sr38G12saQwrZuihZw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jan 22, 2024 at 04:37:09PM -0800, Hao Xiang wrote:
> > > +static void set_normal_pages(MultiFDSendParams *p)
> > > +{
> > > +    for (int i = 0; i < p->pages->num; i++) {
> > > +        p->batch_task->results[i] = false;
> > > +    }
> > > +}
> > Please correct me if I am wrong but set_normal_pages will not be a part of the final patch, right? They are there for testing out the performance against different zero page ration scenarios. If it’s so, can we isolate these parts into a separate patch.
> 
> set_normal_pages is used for performance testing and testing only. It
> won't introduce any "incorrect" behavior and I would love to see it
> being part of the upstream code. But the argument that testing change
> should remain private is always correct. So I am totally OK with
> isolating the parts into a separate patch.

IMHO we can allow that to be production code; as long as the new zeropage
detection parameter can allow user to choose "none" (as I mentioned in
another reply), then it's not a test code only but allow the user to
disable zeropage detections when the user wants.  Thanks,

-- 
Peter Xu


