Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69735C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 14:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFD3f-0005FY-20; Wed, 14 May 2025 10:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1uFD3c-0005FE-GK
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:26:04 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <isyanfei.xu@gmail.com>)
 id 1uFD3Z-0005iv-Qc
 for qemu-devel@nongnu.org; Wed, 14 May 2025 10:26:04 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so5876844b3a.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 07:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747232757; x=1747837557; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQuivvFyAynapqZkeEW3yh8LdgGbYahAMAI7skX49w4=;
 b=bstLfQXj/9CL//EqG8HQCTbWD6HBWQLCTACFFluyUpjf59jKw/1doy5avpEW2OsyB4
 bWDweEyVK+j6ORrNU3RFya1cqaK/qu7pznMpzeS4h7r6cs2D8MhfPour9Wz1p1YMJkkJ
 7PcWG65sIqbFG147CCMYsoycW/FVGQDolWZSie/IUhBhnkI+l5ww/4xdcS9N7Cs6gHL8
 BmMJt6prfP99Os+s27On9aa0F9PfB2z7Oyvy+h9HbCoK81bhXomQoDBK1PeYfkVMjm3J
 rFPf1/EjNFKNnqTImRVgum1bl35T1BS+VMeMV7AoJuzZY9OzxmF6V4lkFj8HtgfGTxkL
 ikVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747232757; x=1747837557;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jQuivvFyAynapqZkeEW3yh8LdgGbYahAMAI7skX49w4=;
 b=oEbF1/yQADmb96xXtVzUn7eFA6KMmlu/NW89lA9S0RfRPrbqZFtvT38U7LqGIaEa1x
 yccXsNubJfq83mziDeleUZyTy8RFIdJPjKZIwtogacNKXd9ym6EI8Q0gAZlp6X/z5oae
 V+l2sAy0oo8Me4UM6b7ljb+rHpEKH6QCiRxOwD9+tF2FE+7NgnLPkqYWD+HSbIyjYtIk
 LfY/KTFoIcgJ5ag2nVzJ6x5PgYAnjQnzTxu4msO6GvWRAdSQbdk2WJ8dzPXcg//JUlQL
 OxpJZCUKWR6Hzq2alHedX8G0DJ/xlnFmBAJEqSqWtjIDoxmC5sHg9+Np+TYrZT+X4O8j
 U0nw==
X-Gm-Message-State: AOJu0YyEmRk3n0DjzPcrVeobb6+YDVEYTKmWbZ+ksTk7WD4H6nK5HZaH
 k3Zf5hSMg94iaa/rKMiIh2EzMHajZNG1wZco25QUomQNOy5u3BNb
X-Gm-Gg: ASbGncvzOro96MgNIXRU6m2kQEZxkNP0qUFmWOYD9S7cN5qz3t1LMuJD+J38dyvpwa5
 18fWP+f/ZO1OlI+pvDz/afmqtE+GhPKcQv9blyFVW0JTRqfCdKR60xY3E4Gpye6Byny0OPEKMVZ
 FQZg3MroAywfMtglw7mlgfa8BobY2RN/ixEAe4jqqN5fxnAn0bRY1OrfvdIcvT46gRRwJAYa9oE
 JDp2GjaMdbvWCYi4KHZTs5wQT871Am2X7vxCB+x7aFaQJ1IybSgiNPcXycK9SgZov3T6y6ABA3x
 YKESpnm2iYdKBiOgBr7j+nbEkbB67EKuh2jMvskQIkNDVViAebPw5jKb4P53jy6ok++98dU5nu5
 G8pTV2iSY0XFLVkytA3ktfXm8zbZXfZZn8wA90w/B6v0=
X-Google-Smtp-Source: AGHT+IFUJmX7wfZxTk0G+Ii6C1UbZsDNX1yy+yL2Ya4e3THcbcjiN9pOrOZPCgZiaj8zKXWUK0oJSg==
X-Received: by 2002:a05:6a00:1404:b0:740:4fd8:a2bc with SMTP id
 d2e1a72fcca58-74289261935mr4671155b3a.5.1747232756868; 
 Wed, 14 May 2025 07:25:56 -0700 (PDT)
Received: from ?IPV6:2408:8207:18df:2af1:f45d:6909:33d:bfd8?
 ([2408:8207:18df:2af1:f45d:6909:33d:bfd8])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237a0f141sm9564653b3a.117.2025.05.14.07.25.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 May 2025 07:25:56 -0700 (PDT)
Message-ID: <0272bc85-161d-4e6b-88e6-0efc651a3ff9@gmail.com>
Date: Wed, 14 May 2025 22:25:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] migration/ram: avoid to do log clear in the last round
To: Yanfei Xu <yanfei.xu@bytedance.com>, peterx@redhat.com, farosas@suse.de
Cc: qemu-devel@nongnu.org
References: <20250514102733.3114824-1-yanfei.xu@bytedance.com>
From: Yanfei Xu <isyanfei.xu@gmail.com>
In-Reply-To: <20250514102733.3114824-1-yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=isyanfei.xu@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Please ingore this email and reply to the later identical one (sent 
about 1 hour later). The duplicate was cause by the network latency - 
sorry for the noise.

Thanks,
Yanfei

On 2025/5/14 18:27, Yanfei Xu wrote:
> There won't be any ram sync after the stage of save_complete, therefore
> it's unnecessary to do manually protect for dirty pages being sent. Skip
> to do this in last round can reduce noticeable downtime.
>
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
> ---
> As I don't have proper machine to test this patch in qemu and verify if it has
> risks like in postcopy, colo and so on.(But I tested this idea on my rust VMM,
> it works and can reduce ~50ms for a 128GB guest). So I raise the patch with RFC
> for suggestions.
>
>   migration/ram.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index e12913b43e..2b169cdd18 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -838,7 +838,9 @@ static inline bool migration_bitmap_clear_dirty(RAMState *rs,
>        * the page in the chunk we clear the remote dirty bitmap for all.
>        * Clearing it earlier won't be a problem, but too late will.
>        */
> -    migration_clear_memory_region_dirty_bitmap(rb, page);
> +    if (!rs->last_stage) {
> +        migration_clear_memory_region_dirty_bitmap(rb, page);
> +    }
>   
>       ret = test_and_clear_bit(page, rb->bmap);
>       if (ret) {

