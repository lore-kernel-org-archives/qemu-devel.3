Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96035FCA17B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 20:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzhGr-00022r-HS; Mon, 09 Mar 2026 16:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhGl-000225-KY
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:32:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzhGi-0006Xw-8o
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 16:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773088318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0VIlvCIjiqHdNMn99LJW5AFJJCwAsed5SIEP+hdAyz0=;
 b=SHjmxCy6xCAK6uMe07ehChLW9MPdkGvt2NUMYrOPgvGJy1UWPVaXLND+zTX5BaQ3YIdlOv
 NJ9Mr2Pp6d+FT2fz+o1HXq7yS8djHNsRkjcMx0np9q1o4snDAYms7Wy/WT36AgN9NrFTUO
 ztDSlG/jik0d0SY6lVeJs0K0JFppzx4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-8z2pTz37NtCOjP-9laKofw-1; Mon, 09 Mar 2026 16:31:57 -0400
X-MC-Unique: 8z2pTz37NtCOjP-9laKofw-1
X-Mimecast-MFC-AGG-ID: 8z2pTz37NtCOjP-9laKofw_1773088317
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50341fddb89so793842271cf.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773088317; x=1773693117; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0VIlvCIjiqHdNMn99LJW5AFJJCwAsed5SIEP+hdAyz0=;
 b=cZR1UrYPXmPdjgDEGVkGsxVdIcJaOIzQAROD8esQnPMIC4do6IIZZk7nJqXwucsOrj
 pjR5HTy2/yKHRK2qr3vIoyVoq7RTdqrtDDCjtDm1apZgh+Aj96ccpyksTkQUJwOJojOR
 /w4X7kgtX2rVToqMFM4N908bW/uPf6OHaAVD5np4aIMJzshPtq+j0AZGsheZ1nYGqqYt
 QQjTdRa2rWSlLx4A2nqLVrarnGyZWO8AN73j8scgokCcryCPmJTNwzYbH/TuXmI2pV8O
 5oBMGXbidPZCEto2ZfQ6EXmA8Eeaji0O/2pKoHphjDbC+JzE+HUYva7vfLA6c9V9ZC5E
 8dYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773088317; x=1773693117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0VIlvCIjiqHdNMn99LJW5AFJJCwAsed5SIEP+hdAyz0=;
 b=ecrJgUCdPdp1JpPheEH+ujFLhppd2EF7PWazJ2GpmWGVSW3nGZO9R84qjIw5sulsiy
 BaH5zsGBJfxTIpyXfFcW4GgPg6Zq67VVUczOyTwa98XlM3Z5YaUtKohBzmkbmManNqiR
 A8jZ0G6llwyArcNjEcuBKOzrGlx9mPCVMUUlLXZ92e0v+FoEMyh4kZRMZc//bdCy3IY+
 oReTsAv0Hk4fTWYmU9449izUZaAxe9BB2cLPZ16hULumEZPklStmJYlzLEf/+9NSAv08
 nLj3WjQX9cBfLjGd8z6QEumKL3p/5kPVEYVv9xHzeWxn27UYWHHeUZzQpu2YTujP+tax
 Xq9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbUj+RpuP8W//pHWZOXH+WA8k3jyaJ6AHRiLfiSeXU4UR7uFDrQxpIDL9P3tojg5R5JpdGbeqCpU40@nongnu.org
X-Gm-Message-State: AOJu0YywBtXO/gT3ilQrHV1BjBJXgww/ckdqGCdyLAdvodnlvZW4749h
 Exy7y+E7SVwWjdXkz4P2Cw//CCBCtJK2yUIAP7oqqsRyvyz9OwnmoDgi1IStoJeUC4hcMWx95T+
 j5D5uo71awy4pHLRyhTJIDPMJ7FtG5D6x+nkIJmzqnAfkHVezlcnAy+1g
X-Gm-Gg: ATEYQzzwe0SJbv8pLbK/saiUThIbBbKVowEzCB893LGTP4b7eQBOEIWvJRjpQuEFwa5
 SvJ/iSe5Sx1vZL3PT1TCWG/4k5TGrDiDbsRGn5MWm8vQAh7kI9GiTVjsnVj0J9V+IUCvH/4lwzS
 wrqMlFQarjS5nqtoXQ3tFQbxiP3PS4a1mM2aB6zuDIbAzehE6Yd/9S8Ckj8BdsFI5Vrf3Tn8qGL
 pk2BqOb5RjkYywxF9/mPIqnNrtX3LLI4s3BvEvvZVqOKOm9B1doL2Eeg9j4yPy8SNHiPS5ce2Ag
 HP/+1aswV5VS2dnlNuJAuFS0r6ySjoJu1zj0mWTzywpwrD5DVlgVvvUaoAi6uDhq1JEkUwaEYv8
 ZmuakNoHQvxn2Wg==
X-Received: by 2002:a05:622a:199f:b0:506:2041:13db with SMTP id
 d75a77b69052e-508f491cf8cmr155552951cf.49.1773088316534; 
 Mon, 09 Mar 2026 13:31:56 -0700 (PDT)
X-Received: by 2002:a05:622a:199f:b0:506:2041:13db with SMTP id
 d75a77b69052e-508f491cf8cmr155552701cf.49.1773088316032; 
 Mon, 09 Mar 2026 13:31:56 -0700 (PDT)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a57a45193sm5131526d6.18.2026.03.09.13.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 13:31:55 -0700 (PDT)
Date: Mon, 9 Mar 2026 16:31:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: leaks in migration-test
Message-ID: <aa8uMNbvhrhGMNDC@x1.local>
References: <CAFEAcA_3ed-jb+P8SVh6Pj8uGM+aYcCHTZgvzzHEUFW5zSn3rQ@mail.gmail.com>
 <87ldg11a22.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ldg11a22.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 09, 2026 at 09:06:45AM -0300, Fabiano Rosas wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
> > I'm continuing to work through leaks reported during "make check".
> > Some of them come from the migration-test. (For these to actually
> > appear in the log you need to run with QTEST_LOG=1, otherwise the
> > migration test framework will send stderr to /dev/null and the
> > tests will fail without printing the leak report.)
> 
> I'm pretty sure something changed that caused this. In the past the
> leaks would be reported by the parent migration-test binary, so it
> wouldn't matter where QEMU sends stderr. I don't know if it's QEMU's
> build environment or something on my machine.
> 
> I'm also seeing in dmesg after migration-test aborts, which didn't use
> to be the case:
> Process 23732(migration-test) has RLIMIT_CORE set to 1
> 
> Anyway, the redirect to /dev/null is a pain for other reasons as well,
> we discussed adding an output filter step to qtest like the iotests
> have, but I couldn't find the time to work on it yet.

Just to mention another thing.. looks like asan supports this:

  export ASAN_OPTIONS="detect_leaks=1:log_path=$SOME_PATH"

Then it can dump leak reports somewhere else than stderr.

-- 
Peter Xu


