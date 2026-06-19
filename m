Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38033CD98F8
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 08:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waUZk-0003dS-CK; Fri, 19 Jun 2026 04:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1waUZi-0003dK-Lb
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 04:27:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1waUZg-0000nb-Pr
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 04:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781857659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=xa5v2MUNyuvl+9PA6LzHGGvsebG0+OEQC6QBGOXh4bU=;
 b=VYBbUmbvPg9YpcKQ55Dqe/AC9lMot1+szyhBFUlyIzbH4cbqzBob4AcVlMouyASCoG4qDC
 tq5Q97JZ6su5CRs0JjtzfUjv00z+lnLyLQXevU92SFTUHBZZH1j4dk2baGS6muhuvqH+nv
 b3ZxM+kVXpsWggW2ZhwuZ7dSOSWA5K8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-HRWjvYk7NTS9E5YqrwWcYQ-1; Fri, 19 Jun 2026 04:27:37 -0400
X-MC-Unique: HRWjvYk7NTS9E5YqrwWcYQ-1
X-Mimecast-MFC-AGG-ID: HRWjvYk7NTS9E5YqrwWcYQ_1781857656
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4629f312a67so1883109f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 01:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781857656; x=1782462456; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=xa5v2MUNyuvl+9PA6LzHGGvsebG0+OEQC6QBGOXh4bU=;
 b=nMfXolKcrLO2Kw+qPBwTRmOxTMsApwxxTc1mM736NXcVCeT24JMS2w0cYJJSt1iidN
 MI9ajxQ05CCsxeisEzGtcZr3xDgS8Fio/ier9/Mt4bVeGYlILrS4PNu626rjDn4VkX+s
 ABQLeVyxeoX0LosLCGp8uVLv1xxRfBsTeRTLmesIWAjk8vMCW9w+wqkCdTfJfpbSdGwp
 RmoCmDFapZFY5djVoDq8ArH/TpP2CNaFFHaCZz4RjQ2kYedev3817vdOdpD4FOm86h+f
 LwFm59fdyGDAhgjrhHVKsQo7j2hsL3/Vz6kTPagUJ16/iCIQBD8u4BZJxI+ycbdBMCGd
 PE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781857656; x=1782462456;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xa5v2MUNyuvl+9PA6LzHGGvsebG0+OEQC6QBGOXh4bU=;
 b=pjQtb6Ewh91D20TvfLN2ywTMwA4faoCgRwtjtYf6oPcDAPpKovhbNAZR37Y2QeeUSr
 FQTQW5FHKCQ+xbiZeQ6+BJQpbtxKn6QoIQ/ERANjlm8fFiVvu4w9uuoC31pXbcKruWiw
 NGtVZHJ3/FLzN9BDUzHXd4awzvfQ7OsJ7v0M+hOksDVTw69zTAL+FRuYgc1cpAghrnhb
 7qSSQWHee2DRx72PJFsbPRob3asW05baeEU15PaotYI0mcyhR/2iUMipXLK9Z3RyHTKr
 ANnQKVHWv5ftUoGKn6Mhjq3P/td1r+fYetZwmzsgDDl3TDHPS3xJBIxV6bx5rhyfB1Mv
 g6SA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8VKLDyns6Mwh4PVfp1ab04Mzr1eTmKz6ULZW4N1H9zY6Vkj4XnbQi3S1dQY+keP4zNRxZaP0v9GirG@nongnu.org
X-Gm-Message-State: AOJu0YzMQj97WwkTJmMlSYfIjhgyXFhp/KCn0LWL+ZuG53wS0hfkO05R
 JjUA5KPWMXPJnVW+Fi0A8q1BkxAF4ANbpSxPUbSlPKc45a5KRpBZfPobwVyYg8C2+rtdCtbQBWu
 ksZzo90SD7BanEySbwZC1J662htGOEIkPxhkPlVyu3t33luTJ7n95iAmY
X-Gm-Gg: AfdE7cnkEMoRLD9B8v1h4hlrSaX/yy/Nh23igJ19jtFwA4Uq0dKKvpQ65+LUlR4Ylac
 uuC6ETCVmRrpr9UsZ8wB+uKRPsvNUe58Iv6A4D218Cah3SWb9Y/ey621kdrsXYOLSXqN23mDSBN
 k9VW8E5GzUxzYlg+MZ/yAAd7GGyvJ/idATKVClcBJpwIFZXfPgkrAMBh25vfFIl0YiUimLFKnLg
 TnxRv945TH+og3Ax6ezPfGCD9rYFZs07IaL/OOarXTyMcuUAM9GgAh9rly6LQkeZysynF6cxKFX
 ki8fIWqvr1E+Xee8bqt0OB4bSCsOR+tKlkwnPaoWcO6/E1nQf1y95BLmZhGCKvdJzFqIkE+v5WB
 c4kh6nfQ=
X-Received: by 2002:a05:600c:3b26:b0:490:52fb:12dd with SMTP id
 5b1f17b1804b1-4923ef5b897mr59701095e9.10.1781857656184; 
 Fri, 19 Jun 2026 01:27:36 -0700 (PDT)
X-Received: by 2002:a05:600c:3b26:b0:490:52fb:12dd with SMTP id
 5b1f17b1804b1-4923ef5b897mr59700645e9.10.1781857655764; 
 Fri, 19 Jun 2026 01:27:35 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.89]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd15470sm56484225e9.2.2026.06.19.01.27.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2026 01:27:35 -0700 (PDT)
Message-ID: <ff565264-cabf-45d7-81e2-a35a23c79638@redhat.com>
Date: Fri, 19 Jun 2026 10:27:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH] security: rework guideline about issue URL / CVE
 references
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260619082236.1175764-1-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260619082236.1175764-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 19/06/2026 10.22, Daniel P. Berrangé wrote:
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> This incorporates the feedback that Michael provided on the
> just merged security process changes.
> 
>   contribute/security-process.md | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/contribute/security-process.md b/contribute/security-process.md
> index c091fa1..146e9cd 100644
> --- a/contribute/security-process.md
> +++ b/contribute/security-process.md
> @@ -92,19 +92,28 @@ be scrubbed before disclosure.
>   
>    * The maintainer(s) will develop and/or review patch(es)
>      for the issue privately, optionally attaching work in
> -   progress fixes to the GitLab issues. All patches must
> -   include the issue URL in the commit message(s). The
> -   **"Workflow::In Progress"** label should be assigned when
> +   progress fixes to the GitLab issues. The
> +   **"Workflow::In Progress"** label can be assigned when
>      a maintainer starts working on a fix.
>   
>    * When a CVE is allocated, it must be recorded as a comment on
>      the GitLab issue, and the **"CVE::Required"** label replaced by
>      the **"CVE::Assigned"** label.
>   
> - * The maintainer(s) will update the commit message(s) to include
> -   the assigned CVE and issue URL. If multiple commits are required
> -   to fix an issue the CVE must be included in the final commit in
> -   the series, and may optionally be included in all prior commits.
> + * The maintainer(s) will update the commit message(s) before
> +   sending a pull request to include the assigned CVE and issue
> +   URL in the following format:
> +
> +     ```
> +     Fixes: CVE-1980-12345

So far we used "Fixes:" to indicate the commit ID of the patch that 
contained the bug. So maybe it's better to use something like "CVE:" instead?

> +     Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/75

Maybe best to use a number here that does not exist, e.g. "42".

  Thomas


> +     Reviewed-by: Not Me <notme@elsewhere.com>
> +     Signed-off-by: Some One <someone@somewhere.com>
> +     ```
> +
> +   If multiple commits are required to fix an issue the CVE must
> +   be included in the final commit in the series, and may optionally
> +   be included in all prior commits.
>   
>    * When the maintainer(s) are satisfied that the patch(es) are
>      suitable to propose for merge, they must be submitted to


