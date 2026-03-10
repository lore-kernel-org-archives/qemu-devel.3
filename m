Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486DCFD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w000T-0005kf-UE; Tue, 10 Mar 2026 12:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzzzZ-0004vm-7B
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:31:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vzzzW-0002GP-Qz
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773160289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BqcZXceZvt9TIoxd5lrkzndpyonyP/cLt7YWX2ygM2M=;
 b=MaRsW2cPOTe99jcxLojCRLhVQwH8AQNhBCluf+23/UoNPqxrlw6IroBA7NIWuBJyC5Nj35
 rp+QBaXVholFeeBpsnJVCicNojgI3SqittNeabuYzaOKAFbhDb80l5qNONWz3ZpcRc26Vw
 ZiIOlj1yUOK2lG0nn/6tKIKNqbvpQyE=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-6sPcor7qO7ik53b7NVBH-g-1; Tue, 10 Mar 2026 12:31:28 -0400
X-MC-Unique: 6sPcor7qO7ik53b7NVBH-g-1
X-Mimecast-MFC-AGG-ID: 6sPcor7qO7ik53b7NVBH-g_1773160287
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-64c42aa5d66so24600529d50.0
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 09:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773160287; x=1773765087; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BqcZXceZvt9TIoxd5lrkzndpyonyP/cLt7YWX2ygM2M=;
 b=GuUWjzEr/ggY/XLUyCIwOZCSKWCCMSpTq6bKURVjvQ4FuzlaO4u9OmlH84EHBbwFb/
 5WXGKFFbqlQ6ZMm989xTLcqd3QFFVrntXNjD5f9OcgICseB6TCQXEXQi7DOkB0zmiunL
 Dsx1hGB0ecfjjBf+9bgHUioRdjjsD3Ry3TnHCJG/FehadXnAPgFpKriGDe/V0nl+f2X0
 VnqSn13+xMN7tzgiyJyUIp4u6R0dQKMsxWE8ZpqsVdau8nVqKfBMKW8RPQw6C3JzWCnt
 rj/wmxHdeq5XRu53VDBfjrfj9SWmzX1xsMk16vDiFCtyx3T/wG4MD4oc0BLgwRZ/9Uog
 UIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773160287; x=1773765087;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BqcZXceZvt9TIoxd5lrkzndpyonyP/cLt7YWX2ygM2M=;
 b=dFDSeVm3INpeW805DO6kaNthvcfD8sKtDZxyEnUXdvcoT8bRukbKcpYj5S1W/Rl1S7
 rX8tKtqlqaosRauJFMhiNEhAG2Umdk2ojtCQHTHCHzU4+NtKpooUOyRdRDMDlgTCW3O+
 zk0kMcMqexAmGo+0CCFnczjkTOQYxRzr3oKuq5KNTDu79j+qtbuJNs39nSNrkzgUSsGl
 +qfZYSDkzgOhGKBg3pCp9+0VjYQMKm2AE5b4CBC1vZE+NUOCpTLAVSWSlZa45G5Su8uk
 Wgxbra4IpgrHnDawnwwXg1riHf/ggcxUJOC02ll0T4zdnlw2oDBb/rZDauI5WTfHgack
 xCQQ==
X-Gm-Message-State: AOJu0YyIeCAMt6Todwz/lMkLExrkfdfJWGcht4knHTvooyMI6N/ktoEJ
 0NNuF6fJmSfBiT+CQAdsvgGvtnt16/9a7uxKxhmcdzryiGNPlYHPmnJeFAS8zQNuGKrXG6so/Yw
 7ZsWLmNHT3RBcUybud4eS6CCLwXhaqPTvl1QrlUa6pmUo9dd36a/+T3lN
X-Gm-Gg: ATEYQzyFJdHY84sw+AYfXYMI8tCwvLALdJiiEqgEc+gp/8GGSBTfhtSHj8aDCt7nem9
 9Br/KWqaIOnn2zo35/gW4XZCT9N4nmuthRAR2zXc202ntLOj1nCAMFkuO2xOuS1p1DGKfeGnywr
 4uNplUTXhYu5Dt0Qqua0indaoX1MMj0tWcY0v/FDgMxoVyZegIAg/C9tQcWchoFsmtbS4aOKh4T
 OLaTUu3GZ8XI9N9SlbjZKzV5DCazSsbcmrzuuYk46gwntzBSZKVhF6uYudVK8ckLRz0ne/7mvHF
 pnq0ppiJvE1tAcZ1AREoXRsKF6U4OpsjGid0BFuAqkUYjII+H39xldN0RcU87vFAdCES8vSauRE
 +Vj/j460+0kdmdg==
X-Received: by 2002:a53:8647:0:b0:64c:a9ac:90b1 with SMTP id
 956f58d0204a3-64d14140708mr10251348d50.20.1773160287144; 
 Tue, 10 Mar 2026 09:31:27 -0700 (PDT)
X-Received: by 2002:a53:8647:0:b0:64c:a9ac:90b1 with SMTP id
 956f58d0204a3-64d14140708mr10251300d50.20.1773160286445; 
 Tue, 10 Mar 2026 09:31:26 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cd6f573580sm1007194685a.48.2026.03.10.09.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:31:26 -0700 (PDT)
Date: Tue, 10 Mar 2026 12:31:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Roman Kiryanov <rkir@google.com>
Cc: qemu-devel@nongnu.org, whollins@google.com, jansene@google.com,
 jpcottin@google.com, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] vmstate: assert that VMStateDescription::fields is not
 NULL
Message-ID: <abBHWwiqu59wCAOY@x1.local>
References: <20260309223116.3233668-1-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260309223116.3233668-1-rkir@google.com>
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

On Mon, Mar 09, 2026 at 10:31:16PM +0000, Roman Kiryanov wrote:
> The vmstate_save_state_v() function does not
> support NULL in VMStateDescription::fields
> and will crash if one is provided.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>

Thanks for the patch.

Yeah I think assert it is fine, but maybe unnecessary, because we have a
lot of such in QEMU (and IIUC in most userspace apps, likely even kernel is
the same..) where we assert by directly reference it as a pointer..

Here, the assert() only helps to crash slightly earlier, rather than the
field->name reference later..  While in both cases it'll be crystal clear
on what has happened when a QEMU coredump is generated, either at assert(),
or a few instructions later.

PS: please always copy Fabiano when sending migration patches.

Thanks,

> ---
>  migration/vmstate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 4d28364f7b..5cb173ea25 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -433,6 +433,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>      ERRP_GUARD();
>      int ret = 0;
>      const VMStateField *field = vmsd->fields;
> +    assert(field);
>  
>      trace_vmstate_save_state_top(vmsd->name);
>  
> -- 
> 2.53.0.851.ga537e3e6e9-goog
> 

-- 
Peter Xu


