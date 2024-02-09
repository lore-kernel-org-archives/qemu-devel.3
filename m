Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6D5C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 16:52:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYU63-0005aQ-9u; Fri, 09 Feb 2024 11:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rYU61-0005YB-Co
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 11:51:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rYU60-0000Yc-3R
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 11:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707497482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bgnD26pSBmRKMLDnCw0kuqUKi3UuiB1i+n6sDMnU/mQ=;
 b=azaRGAHPzfvco91M/uDQEHEWVGyeTxeyWbRIu5TDEYcASfFQXf1XfzzbfLoGI7ewgET8mF
 Homis54zUFUP6H1w78wdnp6rpmMI7MSCrpKKml1EWlz28BMciK1qZojCJkiEPTOtWYn1fY
 ApsYGGHKV3U6SNbWvjI266sTxLY9AKo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-1K5fKqjNOf6Ga0UipYSQAw-1; Fri, 09 Feb 2024 11:51:21 -0500
X-MC-Unique: 1K5fKqjNOf6Ga0UipYSQAw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33b2a223047so414416f8f.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 08:51:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707497480; x=1708102280;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bgnD26pSBmRKMLDnCw0kuqUKi3UuiB1i+n6sDMnU/mQ=;
 b=IaIr35NDEhY64Jz4CQV5NgtcIV532SlhpstkhW/xna/VL6bUzyQbCYFwu48JBm0/T3
 Y4nsT20d2gtkWHsEqHOKme2nhkTzL9BDu+JIMPQGVY/5S7Rwf1MWi/vNFJLSmF3RKe4y
 /vqCuCI+a7fVVMLe37yzfTrSuh/nHujQWnK08gBCieSRwWHYOQtqtPAhqn6On1TdGEtD
 qqh6gTfR0Q7s+OQFsodV3IpgTYTFGaZJpPsAX+xSfBhDIUmV3Py4FsOqV+tgIH1Lq1F6
 bUcvFW28raf9QSjOJ91YiISBOub88xsacGyG2TDAxV26gEWyIxjI5BxcMGbmdv7Ix/Ze
 /AzA==
X-Gm-Message-State: AOJu0YxYQZ1lYasNI/FrQ6Dxxn7Y33VEjjZ3V7CIQUQkfARU+V6jhI0X
 SONaFLFLvqqzgK6ibtWF2doPkE8FzQjZSrEpPfGdxEdBdDmgZHy/LRt1q2kCP6hqJxZdBHRpz2p
 wUlUbCS4uqfrOjZCqYEEclVJpB7JSRTUt6UpwNaAI4faJRYDsSFfR
X-Received: by 2002:a5d:61cf:0:b0:33b:3d5a:d9f6 with SMTP id
 q15-20020a5d61cf000000b0033b3d5ad9f6mr1622758wrv.50.1707497480341; 
 Fri, 09 Feb 2024 08:51:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCik8EXyqeqpkBBpcA2QTJVebqV/SJ/Zm+8NopbCg45HHYr4zJtK4uAYx03EdL/vl0cp1PBw==
X-Received: by 2002:a5d:61cf:0:b0:33b:3d5a:d9f6 with SMTP id
 q15-20020a5d61cf000000b0033b3d5ad9f6mr1622748wrv.50.1707497480058; 
 Fri, 09 Feb 2024 08:51:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU2EdLrUKQEOBXtVQL3ljfLisk75obyd3YUgUbRwZOFRBrhTUIp7SBFoo3wKTnxQj57Aub/kMzmbUUpewl4bdBgOiURFs0G/nceqnV4i8yCC33t+CxD3Dx2sA+A4ic8ih34rXerWXJy0y1EQSfjVtcd8cAvN2FumWgtLhTk1cI/kcPKRJHeNRx9bP2tpwCfJCMn64cACAC2EWQCctMeTqkZH7ZbyFMqqbzk
Received: from ?IPV6:2003:cf:d740:65dc:b9e8:48d5:8408:b27?
 (p200300cfd74065dcb9e848d584080b27.dip0.t-ipconnect.de.
 [2003:cf:d740:65dc:b9e8:48d5:8408:b27])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a056000038700b0033b5730d6aasm2320272wrf.10.2024.02.09.08.51.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 08:51:19 -0800 (PST)
Message-ID: <272941d6-fb76-4c5c-968e-d441c7957646@redhat.com>
Date: Fri, 9 Feb 2024 17:51:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: Allow concurrent BB context changes
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20240202144755.671354-1-hreitz@redhat.com>
 <9bc07eef-da55-4ebf-a4ee-1d55eb6fd921@tls.msk.ru>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <9bc07eef-da55-4ebf-a4ee-1d55eb6fd921@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 09.02.24 15:08, Michael Tokarev wrote:
> 02.02.2024 17:47, Hanna Czenczek :
>> Hi,
>>
>> Without the AioContext lock, a BB's context may kind of change at any
>> time (unless it has a root node, and I/O requests are pending). That
>> also means that its own context (BlockBackend.ctx) and that of its root
>> node can differ sometimes (while the context is being changed).
>
> How relevant this is for -stable (8.2 at least) which does not have
> "scsi: eliminate AioContext lock" patchset, and in particular,:
> v8.2.0-124-geaad0fe260 "scsi: only access SCSIDevice->requests from
> one thread"?
>
> The issue first patch "block-backend: Allow concurrent context changes"
> fixes (RHEL-19381) seems to be for 8.1.something, so it exists in 8.2
> too, and this particular fix applies to 8.2.
>
> But with other changes around all this, I'm a bit lost as of what should
> be done on stable.  Not even thinking about 7.2 here :)

Ah, sorry, yes.  Since we do still have the AioContext lock, this series 
won’t be necessary in -stable.  Sorry for the noise!

Hanna


