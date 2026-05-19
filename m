Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDE0CD4F54
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 20:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPRLN-0005Bi-2e; Tue, 19 May 2026 16:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPRLL-0005BW-DP
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPRLJ-000575-RH
 for qemu-devel@nongnu.org; Tue, 19 May 2026 16:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779223629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XgDn+Q8nGc03AJagiJmPrzfH/X3hU3y/1hyI55M3xgk=;
 b=D0YzVUxy3HolBsFJWVkHo94DfpMUWUhAx9Hfl+ciPNpU0zTHyGqJX0OrgAEpvoOBLKODk4
 B4oIcLyeQfcav2OSCNqLd39ZxokM/oXiJyXgVK5thHk7Nw12xLEPcev7jzeDxjb4rKUYDA
 nUtKdzyxJd9krIhp4izd7azRFnxFUQ8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-PqVif3gJNYSW9VspVZtArQ-1; Tue, 19 May 2026 16:47:07 -0400
X-MC-Unique: PqVif3gJNYSW9VspVZtArQ-1
X-Mimecast-MFC-AGG-ID: PqVif3gJNYSW9VspVZtArQ_1779223627
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-90cbd806004so1025451285a.0
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 13:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779223627; x=1779828427; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XgDn+Q8nGc03AJagiJmPrzfH/X3hU3y/1hyI55M3xgk=;
 b=FFHeuV01UA9ewQPisbGjnp2561DDleOx5c4PQvr2oPgZ40r9N116DlOI+oUfa3KEyG
 iqukWdKNZZ5cSHW/EyQQ3ijAYMom/CY8sx1zUDrbd1iPY6mraLFAhZo5sJAhHCpaEfx/
 8rVtJevU/gKyNvj+OrvUJ71Cki0VD/2LtRNu5nmDJWDWd/uL8Y5nIR9/cVGk5iJFyNlx
 e22Iam8ko46i6KxsSBsAeSZGTpGtOIsX+NYX63vr35WTqJe1gLSG7mSXawIbgxYhMHAh
 6Ydbp4u2iAmdEZScrcFip+fxaHmjHI8liwsUjZg+gFlEZ05cY3BHvBizOPiUf43AyqlQ
 O9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779223627; x=1779828427;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XgDn+Q8nGc03AJagiJmPrzfH/X3hU3y/1hyI55M3xgk=;
 b=e9WYA94HInAKVB+4OPUChXsgEzNzFmGTV97TXTwWhBg/0uT1QOLUkTMRPl5ee6sSqd
 pPvK9Hsm3uAkWJ5ecW6+TYtJjlFB6lR6W0K7ReEY0gajDxOnxLgggJ8IaRQ/NniocmIT
 qqWqeE2ilPkrG/74RNP84tB84Vp7uSk2SsKsFqjkdGt1W9UJ0HoR2YkurrsADwH1U5Vw
 YPX5M+K6cQt2+p3BK6EDltoJieyFVghcmrbKQ14uK28ByaTUAUoaNvjZyftNr4sekU91
 o1ERgrsEoEqPh42rwLAMJepsy5k4So0vpLAuxj7fopmcoPAUwhZpmTRzomUnCDA8KuOG
 qtuw==
X-Gm-Message-State: AOJu0Yy0ITsAXMZKH4k+fnq+bQkx/3iPmqiwklhXB/rULZkKAQOQBA4o
 Z1kVrzIMp3tLtfyHD8QyZnIQu/lwUb0xXUdB9QS+lF1GbgHt+HO0py0FD9mloSTGlpB6GBHfUZV
 m2bdb4o4vXFJcYy2JnfvHwijPhBVSOszRggY7rNyFdZwqq0hKLu4RPsZq
X-Gm-Gg: Acq92OHZa7YFbJuaWDEw2d/7oOeUS/IYIQr8NgPdaUJrhC3nu6yWZArbyOxP/oZ8VKb
 qiV0SD5A/P6QfY04TRyoRs8Xo4PxHPz3ECrNegsNL9bLUwQcQatrMZhS6V2LyaKhVv0k6l7e3lz
 VzR5bNQNz75Rf9zjfDbNXRKUA8ehUS2g7DmGaqymZvrps4xEjfL19nZmYDDPuxRHnelDelSOLux
 7ug86qBl/XDOtsfbcQIQLKixuXzIc7ndAsO6uzPMcxsTBvwyAy+MaEFo6aFrJWjECPOyS4VbZV5
 NYBsjnCNbzyJbn6G9mqHNiqCbrbxXL1Eeug02I/bIf7vNeJtK3n26/Yqi+qmiwr+RnvoIQzzRe9
 R92y5fRu1iBFIT2VRatsb4Y+JaQEe6lI6xs3lD7ZLKNfU1ck=
X-Received: by 2002:a05:620a:254a:b0:90f:786c:8952 with SMTP id
 af79cd13be357-911ce71aec1mr2926310385a.36.1779223627087; 
 Tue, 19 May 2026 13:47:07 -0700 (PDT)
X-Received: by 2002:a05:620a:254a:b0:90f:786c:8952 with SMTP id
 af79cd13be357-911ce71aec1mr2926304785a.36.1779223626532; 
 Tue, 19 May 2026 13:47:06 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b4950sm102332076d6.20.2026.05.19.13.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 13:47:06 -0700 (PDT)
Date: Tue, 19 May 2026 16:47:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1 04/15] tests/qtest/migration: Group unix migration tests
Message-ID: <agzMSKoo-49loQHx@x1.local>
References: <20260505160915.25558-1-farosas@suse.de>
 <20260505160915.25558-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260505160915.25558-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 05, 2026 at 01:09:03PM -0300, Fabiano Rosas wrote:
> Remove some repetition when defining unix: tests by introducing a
> _common function.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


