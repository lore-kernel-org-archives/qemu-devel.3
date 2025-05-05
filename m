Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E993CC369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 06:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBpGj-0005OP-Tc; Mon, 05 May 2025 02:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBpGi-0005Kf-Ij
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:25:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uBpGg-00058D-MU
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746426331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NDjNWi1nYNj24U0zfPau2OvKn6QiG7v2EYXPjnjqWRQ=;
 b=WUVFCgBS8JFdLzi9jE/F7qVWIg/OvdGIinVpvkra09CWT8ccTMQ0Njvt8Itg27Z+b17O2D
 ST0JX3AhnFaGrMZ0ptQz6RLEMkjnm9q+LZaNEWdsLto7pZoJ/vFP/fJ+xiLASjdnQBhKQ8
 h3le8Goq1NOzFNCHG+/PuN4cVEkzXjw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-XX8dsm2CMzKW8j2aRVsd_A-1; Mon, 05 May 2025 02:25:29 -0400
X-MC-Unique: XX8dsm2CMzKW8j2aRVsd_A-1
X-Mimecast-MFC-AGG-ID: XX8dsm2CMzKW8j2aRVsd_A_1746426329
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912a0439afso1076552f8f.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 23:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746426329; x=1747031129;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDjNWi1nYNj24U0zfPau2OvKn6QiG7v2EYXPjnjqWRQ=;
 b=mBljxe804AuDd8qyYw7HKcu06wv0NKjKLgncbzBZ5lxQd9GQEaUCy76HhX5xdfrbWD
 7LobsSrhQ0oFVCIWi+HUjsup0HIUW3eTRd6ljLrGpJNfxwin0sIZj6pgedh6+lAVwj/g
 NH3MCUIrwzoP8/CJGc7p4DbeteJhDbCqiSGhx/mRPuweJjiPXIUN7Ud4DR7VwY5F6L7Q
 QPT9CrOLwVR+Ad7ASR6Mcktiy5oD3zTKbPQnh3NkiiyL6ghwI9Y13lKbVeS1lEkKnTZ+
 FjWO1R+qjOJ+t6dlBz46biA7Cl+PjNaKVO4gCctgkB4ECOR6Mxe2YPg6aTgdiYcLUxid
 YRnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQaUl4QZLn7rQL/fzGwBrG5WIwSoRlfd45illjJA7pdr0Gei6Uf4gWLiB+kqhvQQHkBSl+2QATJryQ@nongnu.org
X-Gm-Message-State: AOJu0YyJpusVJ9NaWm9mi7mrZ/e30frtSDh9wjuDGzfN4aa1EY1/0KGx
 VMEYIbV7afzgqr5z0bsNrB8MeE2uE73KKViizKlgOdjGZ6plnAGcW4YnKMsExJyiiF+LhkGeLlK
 hDF6vV31PrPNc/JG8duzWNBjSClcTjSy99meEyw2GqGdeV3L18GYa
X-Gm-Gg: ASbGncvXMR5b1BF+S4QSv6tMIXcPQBiIeSw1vuSTGznZ3W52Qz1kG4xMyXL5RBQGSSh
 PiaShvi18DBSlGjUtMBE3qCV83mQb5y+tYKcr7f2BUxgfzK6JQ4tYbGHD8c19YClNzYpf7RA5pO
 uyl0L1Edq69xR/QIWMoWBHmZXv3DVAUTU9P4Vr4fv0fee+mUbFPKDgvLnC2g5fpXr72PaOSpC8E
 mVmazmsWOJF9NqiZplFRec8uR8oxwTTvRhmnFJELsq3RYJyLoZjCkszyWNSIU/A3QdRxhJidLh5
 zHvcGCZRB1njtLIVFDpUv/E3Lt+cVB+xJ+diH5EA
X-Received: by 2002:a05:6000:400a:b0:3a0:8295:9e0f with SMTP id
 ffacd0b85a97d-3a09cf3dc16mr5524014f8f.54.1746426328785; 
 Sun, 04 May 2025 23:25:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEv96mwvg2BFvZ5VG6iUnjyj0zAmLUb3SaaXsC8tpRHdgMWQP4t+3MReehurWm3W0sYqMM8A==
X-Received: by 2002:a05:6000:400a:b0:3a0:8295:9e0f with SMTP id
 ffacd0b85a97d-3a09cf3dc16mr5523994f8f.54.1746426328420; 
 Sun, 04 May 2025 23:25:28 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-87.web.vodafone.de. [109.42.49.87])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0ca4sm9489126f8f.14.2025.05.04.23.25.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 23:25:27 -0700 (PDT)
Message-ID: <fb8991c6-c9e9-4e6c-a852-02977942eb28@redhat.com>
Date: Mon, 5 May 2025 08:25:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/vmstate-static-checker.py: Add new hpet entry for
 num_timers
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250501151235.636709-1-peterx@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250501151235.636709-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 01/05/2025 17.12, Peter Xu wrote:
> The old "num_timers" got a rename.  See commit 1433e38cc8 ("hpet: do not
> overwrite properties on post_load") for more details.  Teach the script to
> accept the new name.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   scripts/vmstate-static-checker.py | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/vmstate-static-checker.py b/scripts/vmstate-static-checker.py
> index 25aca839a0..2335e25f94 100755
> --- a/scripts/vmstate-static-checker.py
> +++ b/scripts/vmstate-static-checker.py
> @@ -91,6 +91,7 @@ def check_fields_match(name, s_field, d_field):
>                         'mem_win_size', 'mig_mem_win_size',
>                         'io_win_addr', 'mig_io_win_addr',
>                         'io_win_size', 'mig_io_win_size'],
> +        'hpet': ['num_timers', 'num_timers_save'],
>       }
>   
>       if not name in changed_names:

Reviewed-by: Thomas Huth <thuth@redhat.com>


