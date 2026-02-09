Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B76E81BDC
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 16:19:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpTz1-0000Yz-8s; Mon, 09 Feb 2026 11:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpTyy-0000Yk-Kd
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:19:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpTyx-0001F0-2D
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 11:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770653965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i0WUqoAGV+drE+zgvLVg8uAJd5P42UCIXXtJjOUTlqY=;
 b=K4OEQJ0dhO1w1JngvV8pQJ9pWU7dwkwPVd896kigp+3PTFuvA7K8kejbU6zloQ+ovHak+h
 PrJu6bOab+JU4UmQX586GZ9gFyYsYqUOn6vSvSPtFAVrAdF+yMDH8yZZDKd9KsUaNR1ZIU
 0G9vjfZw9vW05TO/65NPs8yqKEJRZRM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-btvQKi9LMYq2Kzu9yGL-Zw-1; Mon, 09 Feb 2026 11:19:23 -0500
X-MC-Unique: btvQKi9LMYq2Kzu9yGL-Zw-1
X-Mimecast-MFC-AGG-ID: btvQKi9LMYq2Kzu9yGL-Zw_1770653963
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89467edcd21so179436186d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 08:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770653963; x=1771258763; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i0WUqoAGV+drE+zgvLVg8uAJd5P42UCIXXtJjOUTlqY=;
 b=S0/wnVZP58QqvoqwjRdF5dzEPNbJ5GvXaoaFGai6gIRLCFk86ja/llB1F8DkZa4gN/
 lqEA+PWHqP9/wVr+AgpHg2k6wK6LNhEZyxR3O9WZV/QlvhPuFQRZ+wMjX5r/0CFTLXKz
 vAx1GiNRlOW4tXoHXRxBGXbi2xlYSVt5Q3pbzt9Kf7odGivgkogEEll6+MzU++0kq6g6
 t3dX/Z6/FEMmlTU2qU4QOT6EI9il2CVGyoYTVBUBtmEPbJ8JilyOvMxk5LipLNukX21l
 gY/oKlujWxJca+YqScaDvbg/aQBQHapM8TlevBGBIvZuIZnLS3AYuH8LJlkVBYegA3w0
 62Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770653963; x=1771258763;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i0WUqoAGV+drE+zgvLVg8uAJd5P42UCIXXtJjOUTlqY=;
 b=Iy0wnC+vtXO1UAaWs15iHPl7ToknCwTqVfNOvgtDIXdo3WD1yYR0PrhkrMGmX3gEMv
 +dLEncgKWVMNcXvPwouWDIJntYDpodFlLk1cr7J9+Xu00z8P2VDlxvrFA69Xf8ScYtSu
 OzQqpRorlW9RV9ni+J1osPxbDjY5sRlO7AoWGFnD1pjrgbCBs2s2A2d1PFmKULFwgUAd
 gJ1dWA7Zgq2gjJR8f1aVIRA+39rneIkluZt5I2P8UJuRkMDHEPv3nvMCHIybp8sJw+ua
 +2x7e7ncW1R+blgIihgLWW/lQebn1fCzNYReqDTN1BY52mUmxckDhB7TfOX3sMFmRVFj
 OcAw==
X-Gm-Message-State: AOJu0YyqAOqBuvX6JhHcDZm+B6Clgpn6owpk2bq36G3s4bVB/hJHJ+Y7
 EEBR6WybX24DpLsN6cfcSRqQJAjxbYKiVS2O7NrkEKckjJhaFXQxIKRC6vQjITj0N6lxpsF5Gsh
 8hJwcwE1cSroiSwGEJMSQ3Hy0RW2dogKp+Eb2DV13L9MBREUiasMRT7PP
X-Gm-Gg: AZuq6aIuYp8sHHWfHklrHUrptbYCV4tKDXJr3QB4AkK5ieTrFeSLJ7MmRFhg8l5AL9t
 6p9sR5paZ//VI/JOBibNqgKOkKlHzZBXgh9Lx0Z5X57GuB2GGJ77tSyrs106Ol99a2EWt+axII4
 kX3r7w2/6T1bt1qyBgbnpBK1HbZQAjuPU2xPx39632uFs8VRcXal956ThLp32Zzcnuh7A0clg0+
 JJkqiiI9xyob+gGEMHvDXPYbezMhJM5rfSWsZ+TDfqlraJlHj+lqNv/neVPMmjXOHGUco1rapHp
 s3j/i6Ut5clvZvzkS2awmIPhi4AFzAsX3+U/LLVTvKiMp1UQCFa9Eodw8CGM/NCOdBQEy/01Vv3
 bzoE=
X-Received: by 2002:a05:6214:21e4:b0:880:4ec0:4183 with SMTP id
 6a1803df08f44-8953cb9515amr180384156d6.46.1770653963120; 
 Mon, 09 Feb 2026 08:19:23 -0800 (PST)
X-Received: by 2002:a05:6214:21e4:b0:880:4ec0:4183 with SMTP id
 6a1803df08f44-8953cb9515amr180383746d6.46.1770653962683; 
 Mon, 09 Feb 2026 08:19:22 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89546b09efbsm64233056d6.37.2026.02.09.08.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 08:19:22 -0800 (PST)
Date: Mon, 9 Feb 2026 11:19:20 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v5 07/16] ram: Remove colo special-casing
Message-ID: <aYoJCCR0fJBzoZtc@x1.local>
References: <20260203-colo_unit_test_multifd-v5-0-57508b7389f6@web.de>
 <20260203-colo_unit_test_multifd-v5-7-57508b7389f6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260203-colo_unit_test_multifd-v5-7-57508b7389f6@web.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 03, 2026 at 11:15:13AM +0100, Lukas Straub wrote:
> We only enter colo state after the precopy migration is finished
> so this if is always taken.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


