Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B84C54FAA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 13:14:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjIUl-00054z-Ak; Wed, 28 Aug 2024 09:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjIUi-00054F-Ek
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:13:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sjIUf-0007Tn-Tq
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 09:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724850828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AjWgpjQT1HW8Rbqv4V1Y0mknlKhUWN3AI9lQ1XcgrRg=;
 b=QCfUJLqOhUZLN/XygRCkOCZ7mqoAZ29IJMhwKH+9VghTOcvEMCxUweTxdYW4PdIA0iGtRa
 6xHne5MfZzNlSsB+SpMnDlYExguwMp1Qh0K6yl9IdyXgXiuYNSXeB12SKSWCL7RR78m/3h
 amN0Eqt8eaRwfvaSXL2riTMMoeoAdN8=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-m223MMkrNIqfkD4qFayk0A-1; Wed, 28 Aug 2024 09:13:46 -0400
X-MC-Unique: m223MMkrNIqfkD4qFayk0A-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-44febfb1ae4so103904931cf.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 06:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724850826; x=1725455626;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AjWgpjQT1HW8Rbqv4V1Y0mknlKhUWN3AI9lQ1XcgrRg=;
 b=F4k4FP09FJPO0Ac6BOCjhgJ3cHNlkX68NtcB5Q3ksKPOknjpHeYwu69AUKF542JRSU
 XBajrxZeXYzN5S3XXIgweBeNdZtJ1qPGeGJzoHmk//DZF9lUeNLwY5oRSAFWJkZu5NtH
 Fy9H6X/ruFjDN60SeekCj0yH7IEDrWDYy1giGd/DOU9yMEjynnZIItjcCbHR4IUM2O9R
 aIdJ2S+Fd9ZfbAWshZ+cRpfyntKd3r0MOpc8Dj7oLt3fkX4tbN9jXHohiSPy5u638aIo
 z+amZN3DEITnAhmNuVZqi8RO4rkRG3Ydz/rcT16TfV411mKfHHKTSA3HnziB5w3TUeOc
 R66w==
X-Gm-Message-State: AOJu0YwcdSgz0DEBS/8yEWBZgrtem5n/ueIZxUtxCtagRRVOHtfhw2C/
 t8ebhepnMN9QOGIC6mczeOm8Yqyr1wyOGt3J6Ffw8Nazc6yS6dwVpVpx31zNZViu7zJM8A8ccKY
 vawNMZTO4EPrRMdWscYK5okk5+3+qhsnvsHhNyTHplVqu+Uh6CMBS
X-Received: by 2002:a05:622a:1ccd:b0:451:d75e:abb2 with SMTP id
 d75a77b69052e-4566e5e98c5mr25548311cf.19.1724850825866; 
 Wed, 28 Aug 2024 06:13:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSD+ypmwauku9I1LD+IRJxMTCc5b6++pqyaB0Bn9GOifAT7p95yBMN5hYnNRGfZRx9yy/K9g==
X-Received: by 2002:a05:622a:1ccd:b0:451:d75e:abb2 with SMTP id
 d75a77b69052e-4566e5e98c5mr25548061cf.19.1724850825530; 
 Wed, 28 Aug 2024 06:13:45 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-456751bf360sm2742511cf.42.2024.08.28.06.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:13:45 -0700 (PDT)
Date: Wed, 28 Aug 2024 09:13:43 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v6 19/19] migration/multifd: Add documentation for
 multifd methods
Message-ID: <Zs8ihwJLU9E2pe89@x1n>
References: <20240827174606.10352-1-farosas@suse.de>
 <20240827174606.10352-20-farosas@suse.de> <Zs4bL_lRURD7cV_N@x1n>
 <87mskxx0ck.fsf@suse.de> <Zs4ka2-q6JJbL1KA@x1n>
 <87jzg1wza0.fsf@suse.de> <Zs4spTkGlJJuB7LT@x1n>
 <87zfoxogvr.fsf@suse.de> <Zs5H3TtkFfLFDrTw@x1n>
 <87wmk0ol1s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmk0ol1s.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Aug 28, 2024 at 10:04:47AM -0300, Fabiano Rosas wrote:
> We merged most of these things already. Now even if rpms show up at some
> point we still have to deal with not being able to build that code until
> then. Perhaps we could have a container that has all of these
> pre-installed just to exercize the code a bit. But it still wouldn't
> catch some issues becase we cannot run the code due to the lack of
> hardware.

Yes, ultimately we may need help from the relevant people..

One last fallback plan is we can consult them for help at least to make
sure it's working at the end of each release, so it might be helpful they
help verify the code at soft-freeze for each release.  Then we can keep the
development as usual ignoring them during dev cycles.

If we find some feature broken (e.g. fail to compile..) for more than
multiple releases, it may mean that upstream has nobody using it, then we
suggest obsoletions.

-- 
Peter Xu


