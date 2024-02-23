Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA83BC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 19:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdape-00032a-Mp; Fri, 23 Feb 2024 14:03:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdag7-00085E-8d
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:53:47 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rdag5-0000Ug-Ow
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 13:53:46 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-563d56ee65cso1368236a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 10:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708714423; x=1709319223; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9RZ17R5k4g87cMTBG1rXD5DGFpcZzbUQA8pkuFsASdk=;
 b=vKJwp7YtUitboMkX8BR+j9jUC3n6r1SA4W99BywuPmYvihiONWTPVKALYq94ncc3bX
 CAFwlP/uAAe7Yo1SmMBADSsg/ICyXph3cWyVJnGxhyBNIr68jznB6iQVC/LkCIwbAGE2
 ryGthS6qjv1gKjhnFUYI3G0eC+IcxzOPepOMGdoaD4xIIBasXwvEw7WQyevZRdu4tXEK
 xbjR0vjjKDEMdekH4K2GfPTnmWTRFVVraG2Swnhw63kGt5XDUB3EO2mbSWjKpNbxHPz1
 3ixFTcALouV7HpsU4KYuXjXLGSF50YD5mF/khV8YcxQrEPg7q9msRVm3k/cl9VXCoLqN
 j5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708714423; x=1709319223;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9RZ17R5k4g87cMTBG1rXD5DGFpcZzbUQA8pkuFsASdk=;
 b=v89yBS6JNcZDKYOctEiKmoF7/5eJsBN9Q3mYAdPjmiMQVkpQLkkC69GV08l+65r0Ht
 oc4xGZArTxlO392ROyARxTSkGq1TqEumZB2uUAKalmUtOpC6RDW3yps8jiEJc9AJ4S9O
 GMQD3b33euA/qnMQQCEOhO2v7fVbnHQbL+r9489xVjLvSVfhYUYUfDcYcT8oH4PXslJF
 m4l6tNTxSmCMoiHFEiR/1+myWwT5HUsYSIBatu79w1vsRHOSYXyH631GmsO7wuqRcnDR
 zEkM0Lau4Zwf2AeeCgjQbD9cv21z3Oor5GIC2GsGMDuymnBG8uNwPunR+3k8QuFwluXM
 PZzQ==
X-Gm-Message-State: AOJu0Yx8cK2LMzXIFnYL94INrApE6IO9JiXKJfAWYgu5GJxbTpOA5Wpi
 IC7/wN8UQti4i0zbRagbRxW3RBU1V9GFCh4GvOg4bwcvPUsvbhPq9K4IcqtA3wvXaQv1+RRxry9
 kLUvCjiGJzS5/R7yTa4oPDNOA1Q64unpb+ONbVlHiX6aXcwqY
X-Google-Smtp-Source: AGHT+IGPJS7/iolevaDXOKSnikcTUECGav+45QhQI3yKAkdMJ41hqL/gLyNH+A3dykGk6i0KnYBLvscghEF0wNhe0rQ=
X-Received: by 2002:aa7:c58e:0:b0:564:5742:1e46 with SMTP id
 g14-20020aa7c58e000000b0056457421e46mr417092edq.42.1708714423462; Fri, 23 Feb
 2024 10:53:43 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_ncrw8nsD50Ov=Fse=gYFw3CabpURWM9yK3yWmL5CTQw@mail.gmail.com>
In-Reply-To: <CAFEAcA_ncrw8nsD50Ov=Fse=gYFw3CabpURWM9yK3yWmL5CTQw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2024 18:53:32 +0000
Message-ID: <CAFEAcA8x0EYbTuU44r5gB95OsoOL_smt6+8+8VAPkkh5895mag@mail.gmail.com>
Subject: Re: proposed schedule for 9.0 release
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 23 Jan 2024 at 17:14, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Here's my proposal for the freeze dates for 9.0:
>
> 2024-03-12 Soft feature freeze (all feature changes must be in
>            a pullreq on list by this date)
> 2024-03-19 Hard feature freeze. Tag rc0
> 2024-03-26 Tag rc1
> 2024-04-02 Tag rc2
> 2024-04-09 Tag rc3
> 2024-04-16 Release; or tag rc4 if needed
> 2024-04-23 Release if we needed an rc4
>
> (Easter is 29Mar-1Apr this year, but we can hardly avoid
> that entirely.)
>
> Any objections/suggested tweaks?

Nobody complained, so this is what we're going with.
Softfreeze is just over two weeks away :-)

-- PMM

