Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CF6D10DBC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 08:16:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI1ax-0006r7-7F; Mon, 02 Dec 2024 03:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1tI1aZ-0006n0-Jk
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 03:15:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1tI1aU-00053s-AC
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 03:15:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733127320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GX8poXz8bPDx3tAzyouCElin9gaWSiWX6NgkWEE0qQ8=;
 b=OFBs6efmSxKWxckmhtuyo5+QIq/p5qcCUMaMW8UuZcJxElPr0GWma/PwvY+gljxDi5JeNR
 TCCAl1yV9IBfsKsMXxK4gWTyieU+IyXZHqQUc2wa6ODoy6YpRAr+eMYXCPLplRtYIOWVE5
 oP5Nn9hJUyY8BInr9o7Gmq6z0ltI938=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-wmLVRIADOIW3ryV-F2wjKQ-1; Mon, 02 Dec 2024 03:15:18 -0500
X-MC-Unique: wmLVRIADOIW3ryV-F2wjKQ-1
X-Mimecast-MFC-AGG-ID: wmLVRIADOIW3ryV-F2wjKQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43499c1342aso27713265e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 00:15:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733127316; x=1733732116;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GX8poXz8bPDx3tAzyouCElin9gaWSiWX6NgkWEE0qQ8=;
 b=qpF4mvBmfR5lTpQhkNcqIgH4J9LZziDAs+5KKIeCKOm7OuwiZk3rjxOGhZr1akGDBI
 OxwufzPTfsEecKxQE8O6p4xZUbC6XwKCXysEK1nSNQEdkaQabLnRodQ3ntzXsGpsAWTT
 Z0CxMffznCczUzqG8wy1FgKrJbtqsUSfEBKaEgotZ9j9BXJQCRTMsMSPYl/Z6j1CQ0TZ
 oS9wgvCqUTAEG0DJjcd4dBUDN8HIapIEZ00PmTZhTWytSOovamzJj1x2/WYhzl60dQKJ
 g+ZlcHXo0/YsP4/+Zh7layDhKn0ho3RDOjHxbA6VwEXs1vsHFyVVPTOjZAU9U2pV50h3
 FOFw==
X-Gm-Message-State: AOJu0Yzwgq13HRcc9uQ7iqqjh+uEVRwUgJmu4AeLvSoctHnVtWq2Mxvh
 kP6s5Yqf2o59VVI4we/x7sbDBmil3hlZV+ESTyB/bgVMf3mfBQIoZ2iNIUTlrshgWxhat0bM7vj
 B/iRCO6RoJ9ZXFwYvb2Q0FAg+NnTS03oyWZDz3cCxSB5dAzK9mxKmQkU97+gp4G0+SLp5b8cc6h
 Ne7tMgEhNMYT0Z7S1WFOy7jLyKos8huCcW6BJF
X-Gm-Gg: ASbGnctraJ1SmBA8/9YInpZGwoBxSkBdf/+xiAjhUfuXQ/7EplF1KC6Impr9onJqi6R
 NwXlo78mQSRxcOd/OnldcSloi5iIEiq2GIp6I7Z96h/xM7m9KEFcHcdU/e0aw7urFAf0l9kc5nv
 0najlk689Y/swIClBRcHWkfWbRQeNjez0s014wUpxG6ZmbsaCeGjAfVdnngY2EQ8GcoP+VQv3pX
 TXIWeFDvuGNUTkCNekBHJWfocOVdVcKa5Q55Qpz9GMnlptnvbHUeNiF0KeKmOL4Vxc3i68DxYrN
X-Received: by 2002:a05:600c:3b07:b0:434:a4ae:13e0 with SMTP id
 5b1f17b1804b1-434a9dd036amr209171895e9.18.1733127316400; 
 Mon, 02 Dec 2024 00:15:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKyTtyDzffpRWA2MuePW0ldrxYL1v5xes9bPZ67jGrN0+LwUcw6GwG6lmrQMzS6b0zgWGs8A==
X-Received: by 2002:a05:600c:3b07:b0:434:a4ae:13e0 with SMTP id
 5b1f17b1804b1-434a9dd036amr209171635e9.18.1733127316040; 
 Mon, 02 Dec 2024 00:15:16 -0800 (PST)
Received: from [10.43.3.236] (nat-pool-brq-t.redhat.com. [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ea9c5952sm4699032f8f.67.2024.12.02.00.15.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 00:15:15 -0800 (PST)
Message-ID: <da19ed1f-63d0-4b5a-8e57-10d573f0e065@redhat.com>
Date: Mon, 2 Dec 2024 09:15:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] qga: Open channel before going daemon
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com
References: <cover.1730713917.git.mprivozn@redhat.com>
Content-Language: en-US
In-Reply-To: <cover.1730713917.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 11/4/24 10:54, Michal Privoznik wrote:
> See 3/4 for in depth explanation.
> 
> Michal Privoznik (4):
>   qga: Don't access global variable in run_agent_once()
>   qga: Invert logic on return value in main()
>   qga: Don't daemonize before channel is initialized
>   qga: Make run_agent() and run_agent_once() return no value
> 
>  qga/main.c | 52 +++++++++++++++++++++++++---------------------------
>  1 file changed, 25 insertions(+), 27 deletions(-)
> 

Ping

Michal


