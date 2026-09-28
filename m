Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB64CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBCrZ-00045O-6H; Mon, 28 Sep 2026 11:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBCr9-00044A-4B
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBCr7-0000Ug-EO
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790607684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nqE1hMH33fO5PQyGjJQeLBQA+DrbTja0+dbUIZ8ZpUs=;
 b=cwuQ5hFPUpZHl9eiQwnZ3snlBVhqT8koWXMwNLKBrethz/jV8gZtQZ2C1dt49xFDkx9WxB
 0rZ0CljqZPuHnBXnWlEwXETKp3b0ti8WW/LvXcDVG9xxO2R6nFAZmh+addnZWjyy+8jFd+
 lq5TGCloX1nJu8fLyeAy+yDJBggzsoI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-PY5mfjbpOSGbqqTNQPviNQ-1; Mon, 28 Sep 2026 11:01:23 -0400
X-MC-Unique: PY5mfjbpOSGbqqTNQPviNQ-1
X-Mimecast-MFC-AGG-ID: PY5mfjbpOSGbqqTNQPviNQ_1790607683
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53333acddb5so46080081cf.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 08:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790607683; x=1791212483; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nqE1hMH33fO5PQyGjJQeLBQA+DrbTja0+dbUIZ8ZpUs=;
 b=BiwJKXafJARMugNtmDVm0zMxwi9UnW17CH12hH80vgGzcCztM2rfEQX4wiF5QbYlax
 zvZm8eG8cdE9b5AM/RXsZKm2n0orbWHLXO6FUrmNOzLZF8PFmQNSopaLRDjWgkL25F+y
 s4mnoQmbjEle7trW1TX0iRN5POCsAhzPG+B5cS0enJSc2r5fMqlUCEDgvs65uuv2oBJH
 lfQorCxT+3T4zcrdKubf+OBWFwf7eYAu2aDxGn7E7X/NAeAV4iAdCUX+qKIcDDUw/ag8
 +dQEy0ONyb3or33KNJVYa5gEmAjUEYZoiZXZ60j8kH5ATahaGmqeLdFWJ15QJwkFeDRH
 cVSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790607683; x=1791212483;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nqE1hMH33fO5PQyGjJQeLBQA+DrbTja0+dbUIZ8ZpUs=;
 b=iKVmdbS1+o8Hzd+A1aCQU1MOp37JdgQJPrwtA2c6GTVXPb+lXy/q/yEoj0+k+26cBO
 dC8AgteIr9xuSaTCYH55cXQimDQSkAoJ6SAaWwDxcEB9ysUcM2vtRpCx30j+QBHDx5Sk
 nnY+La0gZiu5iRDBbutK+36tizTXpn2malZGCCVnNt4DywRWW5ecw9oxljxWMaLhjBbT
 DeL0uTKJodqqyqLgxiCOtj4vOFYfx/ILNQI1JNUocALsJ2w1oEJDgzLTCNVM7Rw+RIFe
 su/Qv40+pqNWCRbG+CsdCDrHKGZZHh6ING23ipggMw7g+isvrSNmAzKD4KKn52LhxR9V
 o7sA==
X-Gm-Message-State: AFuF++kDH19OrYt2VBF0uoVM5ey86hb7nhqUUOnHQklWM9gWu90RZAHq
 q7myTi/qAjQ1yZUg9pkoOsrJ4qvpJSLULDW4T/3lo5HjP2RpTNZMyInlIPD3CelM1yCOCrNl8S4
 Ur+BAQ/5+3iHKwQL6C1jOQTbe53rRhZSfaaTPjLKHKNaHWZzZ0gsEuSES+Jo1qKrY9tM=
X-Gm-Gg: AYBFou2qzQCTyiyylzFgw5fmC6kNH/AONfsvJYp5nJ3MnGN+KzIRfaMAroqTClrKKGp
 xftLHCKyT5kG66/OChc2eXrtUleO9ghseSHyPJsL5XIdDLWHXS1j+WhF0OhIkQ2cyGa3ATC+rDq
 sRN96QuQdLwq5geF3nWxbQHa93VGO/4fw7I2xGzAPrxS9X+WZ37+gNsbOjfTtE+dI2dZG1yMSzF
 DVcy0VPVrva+p1q+dOzQD8iacyvhuxJHge+n7pNfgBlv2Kuv7OXfy662fT/WVpmNsVA0FKJUYH3
 EYXmI+/2utfTra7pXFoWov6qzWOZTGKr5WRBrU5CMusu4Hy/WvPsnzYLfZnTaLrpeC6CFMI=
X-Received: by 2002:a05:622a:2ce:b0:533:360f:e756 with SMTP id
 d75a77b69052e-533360ff62cmr102493631cf.32.1790607680499; 
 Mon, 28 Sep 2026 08:01:20 -0700 (PDT)
X-Received: by 2002:a05:622a:2ce:b0:533:360f:e756 with SMTP id
 d75a77b69052e-533360ff62cmr102492511cf.32.1790607678362; 
 Mon, 28 Sep 2026 08:01:18 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53322388d06sm64336431cf.16.2026.09.28.08.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:01:17 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:01:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, bchaney@akamai.com,
 mark.kanda@oracle.com, philmd@oss.qualcomm.com,
 vsementsov@yandex-team.ru, maciej.szmigiero@oracle.com,
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com,
 den@openvz.org, sgarzare@redhat.com
Subject: Re: [PATCH v7 16/16] tests/functional: add vhost-vsock CPR test with
 a live guest
Message-ID: <arqBPIhfXllBxEaA@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
 <20260918-up-vsock-vhost-v5-v7-16-6ef9ef033c35@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-16-6ef9ef033c35@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Sep 18, 2026 at 04:47:07PM +0300, Andrey Drobyshev wrote:
> The qtests only cover the QEMU side of the vhost-vsock handoff.  Add a
> functional test which runs an actual host<->guest vsock transfer across
> a series of CPR migrations, for both cpr-transfer and cpr-exec:
> 
>   - the guest is booted on top of a qcow2 overlay shared by all the QEMU
>     instances it goes through;
> 
>   - the host sends a 512M file of random data to the guest with socat,
>     where it's stored on disk, then gets it back the same way; a CPR
>     migration is performed every 0.2s while a transfer is in progress;
> 
>   - with cpr-transfer each migration starts a fresh target QEMU and
>     retires the source; with cpr-exec the same process is re-exec'ed
>     over and over;
> 
>   - the file received back must be identical to the one sent, and both
>     socat instances in the guest must exit cleanly.
> 
> The test needs KVM, socat and /dev/vhost-vsock on the host, and a kernel
> supporting VHOST_RESET_OWNER for vhost-vsock.  If any of those
> requirements are missing the test is skipped.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


