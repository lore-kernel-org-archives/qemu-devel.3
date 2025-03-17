Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE45C35FF8
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 16:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuD8I-0005ZC-43; Mon, 17 Mar 2025 12:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tuD8A-0005XK-LX
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:15:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tuD87-0004Fa-7g
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 12:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742228152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FjnVcBcVNmsAvomuS5mfHEN1afCKBDaxil66bcGEcb4=;
 b=daoEeUIX1ICHNoTKJCTFE3SVq4NbjJ1fvZoifBH8q/b8je9QT6GFeBjmCivL9LhLMDDEwk
 FdCHoE7NcMINSi0wDhxW1mrUv3d4mbFzq3rxnihx/m0HaNKGBmVhOpaxZYSet/96s+zRrD
 2ojJ+0whYPNBP6psRbaBY+aoCGMAZDk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-Rn2FMcbhPFWsC2vrZpoGNQ-1; Mon, 17 Mar 2025 12:15:49 -0400
X-MC-Unique: Rn2FMcbhPFWsC2vrZpoGNQ-1
X-Mimecast-MFC-AGG-ID: Rn2FMcbhPFWsC2vrZpoGNQ_1742228148
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912fc9861cso2113247f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 09:15:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742228148; x=1742832948;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjnVcBcVNmsAvomuS5mfHEN1afCKBDaxil66bcGEcb4=;
 b=I8MTvNrKBpW4X/E7jkUZF3xArSblPkgYj2k43AICkP7bACrRWDDkXvKQK3J+XSF6GZ
 26M0BDIf2P2+ptfcQ9He1reccGTk0x/sHoiaepwyxx87vHcOLcVPQmHbpMZNrfdxBn48
 qRVyqjCaT1vVhvoguQ7Tuw3V6iMMrjZTr0Eosb9YnBAkYsoSJPcy0NsBU28dC3+oOMQe
 K8WDdr++xXJmJWuPutptT8sD+/Ee1ETejCVm0k13J6aLx+nxadFmWSMLojv3u07Bmd0r
 sJ7pf/uxz/paBYULzq9WXHRtQ3jqYQkxqlL4IMZ1WjbSxz9hEGuerggNVGh6DyTbioJf
 5Fdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU24AdPIHqedBFt66kK3f/Ld5NmRI0kgk7hOSoJyAyx3iyqfTa4mqtrQl/lRC63U99fb7KRrouizNWr@nongnu.org
X-Gm-Message-State: AOJu0Yz22IYFcVpqZN3HeemRtCtyqfps8sG83PkXduQ6oEpD4ObdoAi3
 X6bmwsaqY3NNlC+zBEyVQmgvghaW26/XPxtL2vLQHm8OBFtYPl4UhAmLTuEg/tyaWrbYF8j+hI7
 tJ9JBSXr+5uo/BpEiNTEpT5sFhBAchOYf9SKVGaugq6pE/dziGwTo
X-Gm-Gg: ASbGncsRRozpy0NraYwPMvi7j1dlykLFdT3VI2XBWauXbVrTTTrALMkL9rid7AjO9Qc
 0l3PEy6v502KbSDgR8tuct38XiJVCGbJ7rMUoxTKimaWFzknlWK8hw9GeyOHv7tbhOg43VXxutK
 blViGNwOHgKyq+CAZBBePpLmRq2/NEUSBlcN9f4EA4tl1Wgf3JLBDVAK8aQTvl3Mk24v4ckn1ng
 c52hxoUDHHoZ+O6zyqLuhHLb3ofg0rKt1H3OVv64d2DmHRac5VtV6EOTllIjNLdrisLPhJt79j+
 UxLD/H/qOapDI0FYS+APtC0odJ7GOauvhAiweUv+ORUXBGNJCUw+1KAbB72O3sx+yP849xHf4Tw
 KSvS178Jszk/jhCgWOvK2+yRyYGHFjxRI1BROyQ3FEpU=
X-Received: by 2002:a5d:598c:0:b0:38f:503a:d93f with SMTP id
 ffacd0b85a97d-3971f12ce95mr16936346f8f.40.1742228147829; 
 Mon, 17 Mar 2025 09:15:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTw3U8xttNvQy3W8C4yfNwG+XuTMjcuY90SjiWWMwJ/4lSIlMPgSkp/bgGIaEyaMtJostqlQ==
X-Received: by 2002:a5d:598c:0:b0:38f:503a:d93f with SMTP id
 ffacd0b85a97d-3971f12ce95mr16936323f8f.40.1742228147487; 
 Mon, 17 Mar 2025 09:15:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73c:aa00:ab00:6415:bbb7:f3a1?
 (p200300cbc73caa00ab006415bbb7f3a1.dip0.t-ipconnect.de.
 [2003:cb:c73c:aa00:ab00:6415:bbb7:f3a1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe065b0sm108309245e9.14.2025.03.17.09.15.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 09:15:47 -0700 (PDT)
Message-ID: <d7d6497f-75b7-4414-9adf-0b2b8617b550@redhat.com>
Date: Mon, 17 Mar 2025 17:15:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] exec: Restrict memory-internal.h to system/
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250317161329.40300-1-philmd@linaro.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250317161329.40300-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 17.03.25 17:13, Philippe Mathieu-Daudé wrote:
> Only file units within the system/ directory need access to
> "memory-internal.h". Move it to system/ to restrict its scope.
> 
> Based-on: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


