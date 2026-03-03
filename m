Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134D1EDA693
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 16:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxSWj-00068O-Bk; Tue, 03 Mar 2026 11:23:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxSWf-000689-DR
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:23:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxSWc-0000qI-9X
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 11:23:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772554987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v1p49KPP5jzJ17rgTU8/AgGNrbiJPDhS5Keceu5kzlM=;
 b=HvkxMrOmyaKCmM8FmrHFmkRpYf2bGh0YFjnMYg4nuvFs7mMOHt4haungll5UUEC6T9EH/+
 VFPALHB1B9AzZ+vYM5/6ohMU2Sdq4l/islDi9ZBaWPzhi5PBWlNGeMISFsGclhz1rZs3dT
 4m5I3yx1WtaF/e58ZsG+3Q1FK5Om6hw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-kOsC23_APUq7zTSvUKMAUw-1; Tue, 03 Mar 2026 11:23:06 -0500
X-MC-Unique: kOsC23_APUq7zTSvUKMAUw-1
X-Mimecast-MFC-AGG-ID: kOsC23_APUq7zTSvUKMAUw_1772554986
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-506a07740bdso917367741cf.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 08:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772554986; x=1773159786; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v1p49KPP5jzJ17rgTU8/AgGNrbiJPDhS5Keceu5kzlM=;
 b=GVwIHWGJggA6Iu4TRN8L8eYE3x5AvzZs+JDb1XOdbcq75Jx+CZP3SoNUqy0+VN5+n3
 /dnTKf/cWl4qFPF1sSxGRIuIWX/uE/eEQrURa+qHsn7vcbQ39x2XGJZ4yZ0YgueQ8aLn
 RbM16Sz380OuRdRx8/Y2JWkzpvyN/BzqrFePQCTd+leqyzSXLGhrSSTlagHzAu3eBro+
 biBeGSQifVqQAD+OCjjW1z+VGhe57dVms6VL+voPOyDREFFHN5/CPzxRYx75UqW0vWKV
 iSFP6s5OJCbD0Dktark3wrSGBCuRhAylKRV3DX7YCTiMlow2Ov+FSUMniERwl+LoYJl+
 HSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772554986; x=1773159786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v1p49KPP5jzJ17rgTU8/AgGNrbiJPDhS5Keceu5kzlM=;
 b=oGff4lJvABSjazh6Otqu5l8TZvmnUGwqAPtMAjvkhvyWJwJtG3jPwL53cttvM7lgF1
 aYxviQE58ugaBBXLHR5MQ+i7iMAVYGbCiAgD71ZtqMMtbJy4Rwl6cZNpia/J5/g4TrIE
 Z2HSaXmP+8gqdFX/HyGTNaUpC6BOGhsrfKDdn2017XNHBBw6GbOwzahwE7+Ht+qnjv5p
 tLsANHeDTWV+PNXbCkBkWF3psbQXLZUY2Hfp9kax/0w1bjxtjm3xdobotKeaUGBNy9G+
 5wQSq3rX+e611HYLsxt/Ur9jdz+E9MRlMZKeEbGMLHa9IZGFXtYaVxMnZfFcWh2V+y1Y
 Ie3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfn+MYuOaQK8RqZcROF89NydULmcVqzWbti1BE+bJS1kVYVwVzE8JekqE6t9AHfIhbyF1YLpSdd9WK@nongnu.org
X-Gm-Message-State: AOJu0YxqosJHhw3OfdN8SRfRP1v/iLsWYyuIJAcx7S8Ogs8gI4aPLuE+
 PrzZleuXZnWoO0ghEiwsQa2zbAhlTr6j23+WBY0b8/rF82L8QEHUqa7pZEBhaO1XblYV9/vFdfw
 iQDaiMSA7D1OtbIkWc7LGnVbGH+UXfNBOhBQT8UG8TY7qqGo2FhyxFsJkvu8ATD4y
X-Gm-Gg: ATEYQzw3bKLUhdUl8UMDOoYdTWkak5tFwuieAucLS+SL1poNQqryk5oO+zfs4O+BuK3
 ZsbaFIMMVBpMJzEJVIfuo6RxGwC3Lr7pBDi67jPdfa14mjuOSNHjPAuAa0ivyzbrKWPTabh9fra
 sycy6DAG9zEyxhpkoq44MW3Ujf8NU0BOzEi1Cfzs5WBa5DyIsTwSNzg9hy7qLuOZoWK6SklpIMG
 f9ipnghib233TtHIkJXipFl5zYemokr79nXgKkDwlqrbpLjnukCqmo9/iUUZLdPiW8BxLlhKxUy
 O8uuTXDCzpbIxEQBw3v+zrWMloReduoUQnd1WjL7gtY/e9jxoIvgkHktYFb8rxML01rUfHNMDeX
 aWaZWTXB3JEJI/w==
X-Received: by 2002:a05:622a:1789:b0:501:502b:8c6b with SMTP id
 d75a77b69052e-50752725de6mr229682761cf.9.1772554985683; 
 Tue, 03 Mar 2026 08:23:05 -0800 (PST)
X-Received: by 2002:a05:622a:1789:b0:501:502b:8c6b with SMTP id
 d75a77b69052e-50752725de6mr229682201cf.9.1772554985133; 
 Tue, 03 Mar 2026 08:23:05 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-507449630absm137722961cf.5.2026.03.03.08.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 08:23:04 -0800 (PST)
Date: Tue, 3 Mar 2026 11:22:53 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de,
	"open list:All patches CC here" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 13/16] migration: introduce vmstate_load_vmsd() and
 vmstate_save_vmsd()
Message-ID: <aacK3Zy2vjtW6a_P@x1.local>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-14-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220210214.800050-14-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

On Sat, Feb 21, 2026 at 12:02:11AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Introduce new APIs, returning bool.
> The analysis
> https://lore.kernel.org/qemu-devel/aQDdRn8t0B8oE3gf@x1.local/
> shows, that vmstate_load_state() return value actually only
> used to check for success, specific errno values doesn't make
> sense.
> 
> With this commit we introduce new functions with modern bool
> interface, and in following commits we'll update the
> code base to use them, starting from migration/ code, and
> finally we will remove old vmstate_load_state() and
> vmstate_save_state().
> 
> This patch reworks existing functions to new one, so that
> old interfaces are simple wrappers, which will be easy to
> remove later.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


