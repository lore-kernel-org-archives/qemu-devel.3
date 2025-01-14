Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2978BC02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 14:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXhep-0006Ek-HC; Tue, 14 Jan 2025 09:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tXhen-0006EQ-Ux
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:12:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tXhem-0005fP-JN
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736863955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wrhM9Ztf7j0OqIoSmoHcycqKlZfh9DXw7/bTdUpQFVU=;
 b=VXUXscIOknT9RnMoCZHLs1bFzOFOiUKuB0H06fVHGeHba65ZLl8eEHuLUIcLvzfTON28Pw
 ZZyZRIY4QmGTgEwqXCztu9imzylFkhKRxK292LAo6QxV3zz7d5bzWhmaBc/8HgLYlbm7xF
 m0+2simg3jdHA9Ip+B6Qo7XsKIqQnwc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-mmQfaQRUMgyjK1heOcq7DQ-1; Tue, 14 Jan 2025 09:12:34 -0500
X-MC-Unique: mmQfaQRUMgyjK1heOcq7DQ-1
X-Mimecast-MFC-AGG-ID: mmQfaQRUMgyjK1heOcq7DQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385d7611ad3so3134865f8f.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 06:12:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736863953; x=1737468753;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wrhM9Ztf7j0OqIoSmoHcycqKlZfh9DXw7/bTdUpQFVU=;
 b=dqY7lAvc7SKLqEeUaV37K+Rg18TJj3IKCfA6doeLIL109psnEdZzvnCyYFgmNRpW9Q
 XGuh6iRFHVh/p21caGuL3rUtFnNqJ8O9Il/kfPYuIB94poIeaEtmZsYAIABDOzQ007KF
 JmLfeVR5bEoFqM07kVRJ/uU/gJ/OV+q/7gpeDMeAAtITOhJ8uPUyaQ5XrRl6CYXm1X+h
 AuH2+aJHTu3ZcaTVjE9hxNtpcDYUtgERbPTOEYWj1ljqQw1ylSPnW5fZcj4p1pgvyPST
 uzlvGhb/twkh3xMtiCd7CNfFS2Nbx5019AWcF9ljjDJyhtVff7DyBvRdvjmImyqRvywy
 qRUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn2R7jfseVxqeah082Cmcu0aVz4obTMv+KdhQrzEBmlc5TSZQqQs8T1Koh2iIuoBHOIOp+FWxFgGzd@nongnu.org
X-Gm-Message-State: AOJu0YybBXyob5GnCUIp4xQJQc4tDVmkYgZhYJruV6KJ2f+uC+m8btTF
 RHeXsc9lt0HvmiwtfzT+Ybyj/qXox0L8KHegq4ZuT5fIkQRtwvzO/RFT1PuK2uEMgLUHV/x577a
 1bXW4IVffj+6Jo3I4lPe6tJqB1iudAij5DVqJEiFA/71n3+0K5+Ba
X-Gm-Gg: ASbGncvpWJ17njWpgZwfjhBdSFUX6DWeEm19Is63DXASPfbLIjWzAqIpryhqpMKcxR0
 PecBLsFD7OG4uQckrNVmTW4f+HygLErmFv1miy4YUFHNVteSRA79p7mJn8enQMdn1IPXUp4zZrO
 +NLE7umHHBMBBbsaMbNVdzEYQ9yqojoRjf3VkkuEZ/A6WEicwd+5POejmqfVqenNbcIjfICasWb
 rlWPuESHDc7Qs0Gf1TFVyin2gAc/WvedHs7395Gp1AdCYfwrThtLnA+/IHTlgRxDmBnVJK/CavH
 rBOK8sKWgzKefdKq1nkpRS1DtqhGvyZAbqveqgnTuqbyfYwD2OwBgmokp7FkSrEH3hYJJqfPl2C
 /5aHj/8kO
X-Received: by 2002:adf:c04d:0:b0:38a:88ac:ed0d with SMTP id
 ffacd0b85a97d-38a88acee1dmr14379492f8f.12.1736863953033; 
 Tue, 14 Jan 2025 06:12:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoYl5GldX8beX/gtVPZPHAFWijIM5jXdEh1AP7xaxBbwa5OnvRZrIIjk3YwZ7/1gN7jYHnOA==
X-Received: by 2002:adf:c04d:0:b0:38a:88ac:ed0d with SMTP id
 ffacd0b85a97d-38a88acee1dmr14379475f8f.12.1736863952658; 
 Tue, 14 Jan 2025 06:12:32 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa?
 (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de.
 [2003:cb:c738:3100:8133:26cf:7877:94aa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b81a4sm15278188f8f.68.2025.01.14.06.12.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 06:12:32 -0800 (PST)
Message-ID: <7d2765c1-8efb-485e-936b-ea047be7018e@redhat.com>
Date: Tue, 14 Jan 2025 15:12:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] Poisoned memory recovery on reboot
To: =?UTF-8?Q?=E2=80=9CWilliam_Roche?= <william.roche@oracle.com>,
 kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20250110211405.2284121-1-william.roche@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250110211405.2284121-1-william.roche@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
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

On 10.01.25 22:13, “William Roche wrote:
> From: William Roche <william.roche@oracle.com>
> 
> Hello David,
> 
> I'm keeping the description of the patch set you already reviewed:

Hi,

one request, can you send it out next time (v6) *not* as reply to the 
previous thread, but just as a new thread to the ML?

This way, it doesn't all get buried in an RFC thread that a couple of 
people might just ignore.

-- 
Cheers,

David / dhildenb


