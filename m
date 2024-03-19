Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DF3C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 07:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmTcF-0005SY-OU; Tue, 19 Mar 2024 03:10:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmTcB-0005Ru-Br
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 03:10:27 -0400
Received: from bactrian.maple.relay.mailchannels.net ([23.83.214.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <svens@stackframe.org>)
 id 1rmTc9-0004vu-Oc
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 03:10:27 -0400
X-Sender-Id: _forwarded-from|134.3.94.10
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 5DCF94C1169
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:10:22 +0000 (UTC)
Received: from outbound2.eu.mailhop.org (unknown [127.0.0.6])
 (Authenticated sender: duocircle)
 by relay.mailchannels.net (Postfix) with ESMTPA id 8F7D14C1208
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:10:21 +0000 (UTC)
ARC-Seal: i=2; s=arc-2022; d=mailchannels.net; t=1710832221; a=rsa-sha256;
 cv=pass;
 b=gpJbd2kMBzulSRDjtotOYHsP2jNgTQjNaj0ufMVg2dw/erw6xzUtWH8JFR/3p1IGRFF6EX
 Hs9+/uMA1YyPRoVNuvCbSmuIn21RPCGU+Lzt4cz2XvX9v/biRNxtFTep6SdTrN5kf3GpAg
 4sLcHJ6gCSbN0vOK6VaqzfoCfhM4qi76D82eJEnSWH+YyNhfp3t4lEvj/P+yjvEE5Lke33
 bIuU+BMThFqVJwL8XEs7huB0198Z/V6XeOswbOJwNtA4DupOHhvBk4XvRvgMN/8sR+dFJq
 6RDex+vebyVYdEtmXI73Trf9yU9SksXIPTnU7QxfDD+Bi1phGMwladP8cBXVSg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1710832221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=LcsK5zpPCkTUAUiL9BMcQzjr8dc5y+0SXec3Lov00WY=;
 b=JZ6+aUBQMb04mSm2PDAW+jW3+oRPsOhAnoBgLbA/N6O2ZYLEUUa4fLvsYju+7pvEzMCEpn
 osbbcKlTvRn8knaBqDO2acp5kgsxy9qTNVlMvvXKJ3yM4oSVlMfn0lpy92tv9sTuIHnYuD
 KkYpJU73O5htTLEKBdKGgNuhdYYVXIFTjfYKL6mUB8xxjNLzsK4GUVMUXQ8GBPm7DJHphn
 JI5+bSAuHYjqwgZT2bQLLgnzSsjNsrvNdyzLRunAWUrl4MeVvlg1qH6q8GAVevhuJWj6h/
 3vuU0K4GbBG/7rc6BSIRQp+c66NXA/KQnfWfMmqszc3LL097glDnTu5xgCsNGw==
ARC-Authentication-Results: i=2; rspamd-76c7995f89-psfpx;
 arc=pass ("outbound.mailhop.org:s=arc-outbound20181012:i=1");
 auth=pass smtp.auth=duocircle smtp.mailfrom=svens@stackframe.org
X-Sender-Id: _forwarded-from|134.3.94.10
X-MC-Relay: Forwarding
X-MailChannels-SenderId: _forwarded-from|134.3.94.10
X-MailChannels-Auth-Id: duocircle
X-Decisive-Inform: 5ddfc5a8166bd675_1710832222092_1561657273
X-MC-Loop-Signature: 1710832222092:2890245145
X-MC-Ingress-Time: 1710832222092
Received: from outbound2.eu.mailhop.org (outbound2.eu.mailhop.org
 [35.157.29.171]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.127.222.112 (trex/6.9.2); Tue, 19 Mar 2024 07:10:22 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1710832109; cv=none;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 b=uTcY5giIRvMa0Ma7PfrlBGGVtabhd03i0tfLl50QHn7BVJItycwISTFkD1pckYk16U7p3dQkg/zxq
 F3owPlTIomN2CRwXSkryfmZ5Kl3ri2CSpN+sJxuCj+nVEKmPaKkf88keLgsauf/ur2XF/TvLfchxKw
 JLi0auCL9EsdhLyV8sljRz3uGjHf/bX7FGCAdHsMFoidUPeO4gIWfgp1z5nlZ8Rro2TJcQ2UyPi/cp
 Ktm88YplRv3RSshH7cBJITKw1Yxh4ctjGvNTqfZ93wvRI1BwY/xwfS8mt/VfLLEbsoVu5nI416NgzW
 kvaTUHlBvrIwkxnLvJ8THNWaeUwgJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=arc-outbound20181012;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:dkim-signature:dkim-signature:dkim-signature:from;
 bh=LcsK5zpPCkTUAUiL9BMcQzjr8dc5y+0SXec3Lov00WY=;
 b=VKyVqEkSWiNCLYY/Cb2naz5YZWZ/UL4RcGPYF2f+acotIE1kW0Com6Sg3W3JeflLwWWuU3/VZbLwU
 SKvVTPmg+kkf5Mb6rDzS2YpYH2gVnJzi5SPVBqfeQ5igTF4wjYfPv9BdGRJqup7Pkr5NHcdqZ0Jduc
 bwSpwNmk28QWtGq+VwmskP61wDqZl+5sSLWOP3xYS5JOsKzk1zz38Z8Tc0N+q4B6RDCMS3rIBaPI/7
 sZphgZ5PeWmRGr6WksI7IEUDv49KEXEWSgOm8sPKGHa6C9zMODvOCQM0N5Vwyy4aFk3IDT+0VSbZpc
 7UtcokkIcNf+nmRiTRzN6o0zfZ8mxFQ==
ARC-Authentication-Results: i=1; outbound2.eu.mailhop.org;
 spf=pass smtp.mailfrom=stackframe.org smtp.remote-ip=130.180.31.158;
 dkim=pass header.d=stackframe.org header.s=dkim1 header.a=rsa-sha256
 header.b=SllkjHYV; 
 dmarc=none header.from=stackframe.org;
 arc=none header.oldest-pass=0;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stackframe.org; s=duo-1634547266507-560c42ae;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=LcsK5zpPCkTUAUiL9BMcQzjr8dc5y+0SXec3Lov00WY=;
 b=P3jXaF8GxwpH6Z4lY1/UUXN8BoYTzBVh2TloYYIORwT7WWCSdPnL0uDvIsW3x+F5ByYIzHHoh/EE+
 pG705BzOonWDYhsuyZvwLMw+KTIRVIKyN2W/kEtdW7GUXabIUFKI6M6BiSGuJVJqq7L6JDlYdz9Zon
 LdY4gamVJp+sMecY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=outbound.mailhop.org; s=dkim-high;
 h=content-type:mime-version:message-id:date:references:in-reply-to:subject:cc:
 to:from:from; bh=LcsK5zpPCkTUAUiL9BMcQzjr8dc5y+0SXec3Lov00WY=;
 b=l/PfTRTn76FhPAnaigqZXoDbappb+TDYqj7EOShZPzww1iEAuuuqBNzDv4g+Xh8YeQdRb/VYYjeuM
 ZUyO8ARlk1qxr2CiMCyN8UHVDbUUHTdfJcu05bbxdsSlvbOsalXCkgtQ6CTheNOuj+XwiJBpALFpYt
 XxZOnRypvpU6ETaJn5PsegbMhFBRQQn5KIHWrC5pC9hKDkFkfUmH5v/0Qmm4C5d0Lq1o+/jKpfRyIf
 oaq11aUd1b7VQg+EHuQ2K4IOmcypiz+YIRYG2+o5656R5fD5Hadr6OZjWevgG1JF+IOqr7gEw9C4jl
 ymUQuaA6rbiLZ5fCsW+7Kd/dHq046yQ==
X-Originating-IP: 130.180.31.158
X-MHO-RoutePath: dG9ta2lzdG5lcm51
X-MHO-User: 7b431e55-e5bf-11ee-b7cb-9b9d9be6ef2c
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
Received: from mail.duncanthrax.net (mail.duncanthrax.net [130.180.31.158])
 by outbound2.eu.mailhop.org (Halon) with ESMTPSA
 id 7b431e55-e5bf-11ee-b7cb-9b9d9be6ef2c;
 Tue, 19 Mar 2024 07:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=stackframe.org; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LcsK5zpPCkTUAUiL9BMcQzjr8dc5y+0SXec3Lov00WY=; b=SllkjHYVADOJrDJAIQ10G0Y8gc
 67+Nv6idlPgIbhZc/Zv7yiOp5KmNFUBU+STVnSXKFmHnpxeEb4iQQyqlBoX+9Qu+mUP3O2GTEY1qw
 al9eoJDYj+/GigAk1Zc5usHT35dZaZugir4s/mW6Dq2CNYclxAu2v8l75vzBs4ogBoJ0Ut7WvCyr/
 diAzH/LDZ2MgU0BrJhXrIL2elo/jFWSBnfcsLbD0pzXKuVnKy3qEgshb/wcT4Zb14nUHyh1ToE2lY
 Z9JhYNImmSwxthiUsjjtWKqZSIULMqaCtU1RCpeKBhpU5xFfEdAPipFkHJDCelhSMJsKpZnfUmYdM
 hKjcbVMA==;
Received: from ip-134-003-094-010.um41.pools.vodafone-ip.de ([134.3.94.10]
 helo=t14.stackframe.org.stackframe.org)
 by mail.duncanthrax.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <svens@stackframe.org>) id 1rmTc1-004Qji-0r;
 Tue, 19 Mar 2024 08:10:17 +0100
From: Sven Schnelle <svens@stackframe.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 3/7] target/hppa: fix access_id check
In-Reply-To: <1ac51271-1d1b-4623-bc56-0ceb920e7611@linaro.org> (Richard
 Henderson's message of "Mon, 18 Mar 2024 11:12:26 -1000")
References: <20240317221431.251515-1-svens@stackframe.org>
 <20240317221431.251515-4-svens@stackframe.org>
 <1ac51271-1d1b-4623-bc56-0ceb920e7611@linaro.org>
Date: Tue, 19 Mar 2024 08:10:16 +0100
Message-ID: <877chyofxj.fsf@t14.stackframe.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=23.83.214.9; envelope-from=svens@stackframe.org;
 helo=bactrian.maple.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 3/17/24 12:14, Sven Schnelle wrote:
>>          /* If bits [31:1] match, and bit 0 is set, suppress write.  */
>> -        int match = ent->access_id * 2 + 1;
>> -
>> -        if (match == env->cr[CR_PID1] || match == env->cr[CR_PID2] ||
>> -            match == env->cr[CR_PID3] || match == env->cr[CR_PID4]) {
>> -            prot &= PAGE_READ | PAGE_EXEC;
>> -            if (type == PAGE_WRITE) {
>> -                ret = EXCP_DMPI;
>> -                goto egress;
>> +        uint32_t pid;
>> +        if (match_prot_id(env, ent->access_id, &pid)) {
>> +            if ((pid & 1) && (prot & PROT_WRITE)) {
>> +                prot &= ~PROT_WRITE;
>>              }
>> +        } else {
>> +            prot = 0;
>>          }
>
> You're losing the data memory protection id trap.

Oops, indeed.

> Therefore I suggest
> [..]
> At this point there are now a couple of hppa_is_pa20() calls within
> hppa_get_physical_address, which could be unified to a single local
> bool.

Thanks, i'll take your version and update the patch.

