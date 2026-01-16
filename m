Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9D5D47CD6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 10:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vghQ8-0002WC-Jf; Fri, 16 Jan 2026 05:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vghQ6-0002Sf-PV
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:51:10 -0500
Received: from mout.kundenserver.de ([212.227.126.135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vghQ3-0001t6-7z
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 05:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1768560663; x=1769165463; i=laurent@vivier.eu;
 bh=iRKF310EFQNGmCP8paV//pm5V/6sTa5BH+WdGSxH+nk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=2XUO+FbQmuxoB8Er2NX709gYs82rE15uuw1Sfwg3BjHOg1dIEQJee36cRedW7XwS
 z1ayDPU3JF06BIzi+qz/YxnrBfANPa+wFAP25YSO4ODiTP2Z9KZOIIKKmL+eKd7DG
 BUYX27hpXM49iW5U+BQFS0P7zFqFEbPxz1TXgITLrev3cy1vPWSJ8nT39ztY+SiFD
 b9ssZh55hDguKJyolKT2QrKRr5bW2/Tjww26SDM/hE+gKs/JelM3cyUhynTqqYIb7
 NCUBvQUiTNpEQUbBhlqeGQfXjK48gUOQcaYArnjO4zYwfCUgJHQG55g7aDILPk4or
 fjbSukQMGeS6bJ8YdA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1McXwD-1wFCtG2cGb-00ZqXs; Fri, 16 Jan 2026 11:51:03 +0100
Message-ID: <fe632639-7174-47dc-a6b3-7594a04d3a43@vivier.eu>
Date: Fri, 16 Jan 2026 11:51:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add reviewer for linux-user
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260115201712.2706663-1-pierrick.bouvier@linaro.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20260115201712.2706663-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cxIuurGh4d7Dr2qmdIvui9GO3L+DHnu0NDCPHFKbbYsOh3uJdc0
 kuAEdoTHMEmsk7zMZt9kEFnsro+fBZJyTLefhFN+45d1lRslfe2Aew0IPIGw9SwMjLdQXeM
 KazBk9oW9btIwkr6KvnYf637gwHuIv5kkfPPeCinL3DVFv8x2ApDd+JHrX3zsFlS4vz2tOF
 8qMAhROLspXUTgOXYkRfw==
UI-OutboundReport: notjunk:1;M01:P0:e2CELrLxduo=;5f3TNaO3kVDJtlSkDxSwl3S0UFh
 PgYGv3PZ2qNAlRVNH8oKpOnDhc9mu8phZhORPOXTEeXnH/rt4Ikes1GP9Uyq0i9gzhZGFwKXn
 qpbwPsrLK+kn7Vg0GxYHAqQ+UT8FDV9bJ6P/4vcIohNJ/IuPKdLmgarq/uYLnA0Xrhg70ogK7
 rH8YdNPoFOn0/rCUGwKHlvTxsNoiJTOgxbJg0EDSoD05mYRlxEUpKabTNAGbWSMq2W+K1Ddni
 gjy+oaZz7OsRUN+cnH6S3oKnvw255LIrXs3ApIz69dfg1u1NLKugMuId/1ymxxoLf6A0d+/vm
 SnPGPd0DT9RUBjwDI9tSae4bUMMU+w/qqrZ+kjkMbfh/CG/awjaCJ5D/alf5w/HFygzLpE0mq
 As2xCeADL7BR1NJbwM1ozrFLo0GyBWxwPBjVB1dV/JW0YcoGv2KgC2QEZjkjTQCIKkMCCBhdd
 /a/vfR6zI8ETNsjESPSIOdfMKFWqGrB7yXBkupBYMuo2hNnYXpXOuWpnFScv6iuAPDlE+yQZv
 +d0BH00LkleJhcGrTTFv6cv/fLgDwJQj/TUXQgRC7WfEzZxzEitVG1BhOTOTlALdqn6PMDP4X
 OCh+kigePB5d+fB3xA5akhP7EG8rF5g8cvr7XQJCvieGZ/Fj+iKuJByDvhfE9yzEpgaha024y
 My5E/JcmhSV2NxBxtrtR/sJuP2ivGhN4pfZfm0QlCy/SDUyv4m92n74EVUgYJT0NJ+un5rLnt
 gpeX2h0EdWuuMYEKw4CIpCKEEQSpn98OafX3bE9By6D6ooc5f70Fnakg741oFA0KIiBNJMJOC
 oGG2WappWccQpb029okmR2vybB46DsVQLQlsE8jZowf5EjzvX2OjJUBuq4tMT3YUdKJD63TN1
 V9TbgWCGQML8hlOhNZSIferfWbVIdQ0WGQ6IcSBsa1KB8CBEYGAzgVbWfsAP12njtFs61FH/+
 rup0/7POXwB/kMi28T59HEy6sOuCWzp5nrIEdiMspIaDpQh4gWLBRAbwts5j/5X0QCpQvWefv
 uk6U/eCp5ib3coGbrYUDLCCIYuz2v8cWr9eU1Z8tHiKoUIk1lBNd3rzYY/hKtEFibD0O8S4t6
 lrODUkylgeS1pIlCnwAgCAbtj1k98Gdb8jndfM8ukoH1H12eTR6dxmzUKusa1IGw78AvvfXEA
 y4b1QnwL4AbQXUR0T2dmH8ni/wxgUIVaNeiqu7xM9v9pknaHkWbVyT+6MyJAJmEmyaGZrc0Co
 KdhEYMaH/HzIdFeml0GHQJ9R74sh0ImYv4AFZ3zF3/yWb0BpEEsTRFyJ0bEFGxrDHtfPdbil0
 tBccXwYBbGyf3hmgFgkWxvCuvv8l1mrg3JWCcYPagmtdp8/qwneECziqDurB1MaO4Dn/O4Dzk
 iH8ZkKqUpfvGUe1R7IJRgi6YSZ3X60QAub0E7SrkTh1GpK6AuPebpUw1K4nvp7dgHsqpdyUTx
 IcgyAqDMO7crTjN1hlQyPJh1qpReH1n4ouaR9tDIY6JooxdxFnEIQQnVQ4Ht57oUD5uo246gC
 yiLEA54JkFZxUPniIrGAQ/ZMrTyT83AyJywBV0OyYvVH3BW6Wh+KLm15hLcRi60Kqa7dLF4VL
 rVnNxw4jCjos0t1u7q3+m8VbQfUPINVuICkDIqG74pLoj1ggOoEsBh+d1SxKLl6szLXRLJjQT
 3Rq7xopQV6yHcLCjoMCF75kJacyMbyxflP1QSDKCFkv0ZBcd/IAaxsmJMQWyAN58E+pQVKb1k
 TBghaoaaG/047iHV2Fwkq2z+TWLgoh4/IBQy82DlnwfwEYq0oPJE5dBA=
Received-SPF: pass client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Le 15/01/2026 =C3=A0 21:17, Pierrick Bouvier a =C3=A9crit=C2=A0:
> I had interest in this area for some time, and would like to help
> reviewing it.
>=20
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4ddbfba9f01..4ef0c10f63a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4021,6 +4021,7 @@ T: git https://github.com/qemu-bsd-user/qemu-bsd-u=
ser bsd-user-rebase-3.1
>  =20
>   Linux user
>   M: Laurent Vivier <laurent@vivier.eu>
> +R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>   S: Maintained
>   F: linux-user/
>   F: configs/targets/*linux-user.mak

Acked-by: Laurent Vivier <laurent@vivier.eu>

