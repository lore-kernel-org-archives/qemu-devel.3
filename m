Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C56C369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 17:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6v2B-0007BA-Uv; Mon, 21 Apr 2025 13:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1u6v29-0007AN-Lw; Mon, 21 Apr 2025 13:34:17 -0400
Received: from out162-62-57-87.mail.qq.com ([162.62.57.87])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunnyzhyy@qq.com>)
 id 1u6v25-00034q-0G; Mon, 21 Apr 2025 13:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1745256831; bh=gXlukBlyxqitfD4h9zfVXtMgeG1v6nsgK62Y6ggqtdQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vvJz4N7Zesm4i+NjM0S3CNg1USXEUWi+XCN5RfQmPJhGqF5CVkNdzZqlZyz4kl79M
 nYDmVGvJHz5hyiJt54AMAdyZikw6XVaYD1JlWbU16qE2ShUhQJaWTwc2UGX+0nq7my
 cM0GnjWT2WszpxOO/i2C730z2wLEP2316KcXbavk=
Received: from 192.168.182.133 ([117.147.34.254])
 by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
 id 87111AE4; Tue, 22 Apr 2025 01:33:49 +0800
X-QQ-mid: xmsmtpt1745256829taj1o265a
Message-ID: <tencent_FE7A06F963D2DD81589997B3DF66701A3806@qq.com>
X-QQ-XMAILINFO: N1JCMsqefaecXcaVcpLiL5rnLJRqEx6x2WeyPgSut2dePUONmB+i/MU8qppYwY
 tLjvErEeSS0yMIRPBpF26taqrxKuzoyD8Lj7ebh2W4xPcuEDHv0pQsXxCUJ6blEXQDAvTpgBmYow
 acAxMuVbsjzxTCEBcFm8kJ3Z79z203q6e4DffCmonV6sN8nFUd/rttxQJkQYI/wfc18sHe+J6BaQ
 e+AM8LVxwmPuGib+0NNMhw3hCZKymVr+RC7nLYf0Om37Bjt8JJ2EMlwWlM2lPbANxj13K33QZJGz
 JCdUJPSMOxU65oQRj4rdy1TMBxvO3+Us5Kvun+IxEZI/BDRhGs0wcwlYggh4iev1HrdJOLPJc6Y5
 fIsBMTNfflKaZnRZhBmJTt0FXu3TREno3PA1TI6n2+iRex6KSlYst4ZjvQFTLCx6MWuZlJkjoT7N
 pbB9A0tUsB+URWYzehloFtM2/RaTZ9RBuWJ+yFFZAqQkucc+1TAyZTjjMDZ9n84+8+GTfDOWsc8d
 cc2y2yDXXYDkUQUHKTp3P6NDeV3kkiVuuBCNAP1T+uaxBofhU3MJlMX/dt/XoSm4Yx9k8Ogedj2Q
 BEyP2+ru4P6U2/jomp5RWk9rPCQMoESmsBkmtyok8GTn9fNHnBmESKCvYovSV65c2NqadS8wr9PP
 6NWTXy4DCLJeCyLezRGEoIYb246A+x6NduU1EoaVehHDkz0ah1J/w4624rQK8AEmwttxQdqM16dQ
 reGAG11NyNtG82jqcbtIURUKBRqXLD3JsgtcLRSUlOtfMrnCAgnWFsQbltQJceBKYJeqQP3rllG6
 yTcHU06SaGQ8puEqNQwtXbmX1vN3diexq41nGigHW/zyKvVMmXcts46gFLV6daXrBFXRNtty9N3w
 7Rb/j/EUEa+wghXQWzux4w0u6zuiEGmrF9uXTxvD5VUB9bAc5lVNZMTqMWiJe93luBBc3jl8gCV9
 yAyBdVw/kXE2IlZ/T8yQ==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Sunny Zhu <sunnyzhyy@qq.com>
To: eblake@redhat.com
Cc: hreitz@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, sunnyzhyy@qq.com
Subject: Re: [PATCH] block： change type of bytes from int to int64_t for *bdrv_aio_pdiscard
Date: Tue, 22 Apr 2025 01:33:46 +0800
X-OQ-MSGID: <20250421173346.30518-1-sunnyzhyy@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cxsasg7qiopbpwu24a6f2hponb2lv6ut5ylhcpeyagi6g6k2m5@w2c6mwuqi5ik>
References: <cxsasg7qiopbpwu24a6f2hponb2lv6ut5ylhcpeyagi6g6k2m5@w2c6mwuqi5ik>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.87; envelope-from=sunnyzhyy@qq.com;
 helo=out162-62-57-87.mail.qq.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_DYNAMIC_IPADDR=1.951, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Eric Blake wrote:
>On Mon, Apr 21, 2025 at 12:19:14AM +0800, Sunny Zhu wrote:
>> Keep it consistent with *bdrv_co_pdiscard.
>> 
>> Currently, there is no BlockDriver implemented the bdrv_aio_pdiscard() function,
>> so we don’t need to make any adaptations either.
>
>If there are no drivers implementing the callback, then why have it?
>I think we have been moving towards more coroutine-based callbacks and
>away from the aio callbacks; if so, should we instead be deleting this
>callback as stale code?

Yes, that makes sense. I will make the changes in the next version.

Thanks.

>
>> 
>> Signed-off-by: Sunny Zhu <sunnyzhyy@qq.com>
>> ---
>>  include/block/block_int-common.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/include/block/block_int-common.h b/include/block/block_int-common.h
>> index ebb4e56a50..4bf422d733 100644
>> --- a/include/block/block_int-common.h
>> +++ b/include/block/block_int-common.h
>> @@ -507,7 +507,7 @@ struct BlockDriver {
>>          BlockDriverState *bs, BlockCompletionFunc *cb, void *opaque);
>>  
>>      BlockAIOCB * GRAPH_RDLOCK_PTR (*bdrv_aio_pdiscard)(
>> -        BlockDriverState *bs, int64_t offset, int bytes,
>> +        BlockDriverState *bs, int64_t offset, int64_t bytes,
>>          BlockCompletionFunc *cb, void *opaque);
>>  
>>      int coroutine_fn GRAPH_RDLOCK_PTR (*bdrv_co_readv)(BlockDriverState *bs,
>> -- 
>> 2.43.0
>> 
>> 
>
>-- 
>Eric Blake, Principal Software Engineer
>Red Hat, Inc.
>Virtualization:  qemu.org | libguestfs.org


