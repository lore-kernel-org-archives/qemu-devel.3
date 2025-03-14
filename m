Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6209AC35FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 18:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttA9s-0007dw-HJ; Fri, 14 Mar 2025 14:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.67d4769c.v1-16be245bc6504bab9eb1305ed5d9aa1a@bounce.vates.tech>)
 id 1ttA9o-0007ck-8k
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 14:53:20 -0400
Received: from mail136-29.atl41.mandrillapp.com ([198.2.136.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce-md_30504962.67d4769c.v1-16be245bc6504bab9eb1305ed5d9aa1a@bounce.vates.tech>)
 id 1ttA9k-0001Ln-R4
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 14:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com;
 s=mte1; t=1741977244; x=1742247244;
 bh=XJ3a24qpetFIlkUTjB8MUIt/veN1MpcWIkxiqMq1Nms=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=xH+OAiKSmUm4/2oiqH1GoA8oUrr7Vt6/KmY/4NlzrJapPIoIkHeP+9Q4yqfK+F9Zx
 Mh4e6qi17JXa+j6oJwKoNy1NoQqUSqB/gvlene111G//q8Mlc7JDvBJmmEpGKBKimR
 fvzOeCMt4zWdnebpSk3Jgxlp/R1wcxxn01byg3SQZCy1hfHl0d3qRa8SywZ0/d7pnS
 n/uS4hnl63NYhRW/ce8sjTwnWvH6nDbpP6dvLdlWHT4EHDklkabt6ZzCVwRij34nKD
 rTHFzfZZD3fLMf7Xfqk1QwZDK+ms+E/QkIAqsAwOXyjTd6jTfxH/LKLQybwni6vWT3
 XZUms1sJ9HuyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vates.tech; s=mte1;
 t=1741977244; x=1742237744; i=anthony.perard@vates.tech;
 bh=XJ3a24qpetFIlkUTjB8MUIt/veN1MpcWIkxiqMq1Nms=;
 h=From:Subject:To:Cc:Message-Id:References:In-Reply-To:Feedback-ID:
 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:CC:Date:
 Subject:From;
 b=pKWYCvfIR1ts08e4UHFts7qlobnSh7qbX1EEx79CkVs5o75YfRprtpHm0bfkuskOX
 /4C6bpSjV4xq8kEeSs2yNwlRCGTIWlor7SmSPRBOWuB0IQp8egGRHdQa/0MiHQT8gj
 JaoWk28Vdmk7Ta/1SE38+i6o9oimVaMAjsLRxOdPLr+BJHxiQlvBo9zlTBgCbP8hlP
 njxJ3o3HMzLBb9BRzVm+V9fO802nPYibo/39RDFcN6ZZneSaUjPUcrvbaD5GInsZpq
 /em6dPXg3g/R44mU8uFTirheYaJ2Whn9Wz7eZWriA2zwYvXw2h/26yox/UMC9J4NrJ
 a3pphRt5VFENw==
Received: from pmta11.mandrill.prod.atl01.rsglab.com (localhost [127.0.0.1])
 by mail136-29.atl41.mandrillapp.com (Mailchimp) with ESMTP id
 4ZDtLN1Rl1z6CQ8XH
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 18:34:04 +0000 (GMT)
From: "Anthony PERARD" <anthony.perard@vates.tech>
Subject: =?utf-8?Q?Re:=20[PATCH=20v5=2000/17]=20make=20system=20memory=20API=20available=20for=20common=20code?=
Received: from [37.26.189.201] by mandrillapp.com id
 16be245bc6504bab9eb1305ed5d9aa1a; Fri, 14 Mar 2025 18:34:04 +0000
X-Bm-Disclaimer: Yes
X-Bm-Milter-Handled: 4ffbd6c1-ee69-4e1b-aabd-f977039bd3e2
X-Bm-Transport-Timestamp: 1741977242834
To: "Pierrick Bouvier" <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>, "Paul Durrant" <paul@xen.org>,
 "Peter Xu" <peterx@redhat.com>, alex.bennee@linaro.org,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>,
 "David Hildenbrand" <david@redhat.com>,
 "Alistair Francis" <alistair.francis@wdc.com>,
 "=?utf-8?Q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
 "Richard Henderson" <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Daniel Henrique Barboza" <danielhb413@gmail.com>, qemu-riscv@nongnu.org,
 manos.pitsidianakis@linaro.org, "Palmer Dabbelt" <palmer@dabbelt.com>,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 "Stefano Stabellini" <sstabellini@kernel.org>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Weiwei Li" <liwei1518@gmail.com>
Message-Id: <Z9R2mjfaNcsSuQWq@l14>
References: <20250314173139.2122904-1-pierrick.bouvier@linaro.org>
 <5951f731-b936-42eb-b3ff-bc66ef9c9414@linaro.org>
In-Reply-To: <5951f731-b936-42eb-b3ff-bc66ef9c9414@linaro.org>
X-Native-Encoded: 1
X-Report-Abuse: =?UTF-8?Q?Please=20forward=20a=20copy=20of=20this=20message,
 =20including=20all=20headers,
 =20to=20abuse@mandrill.com.=20You=20can=20also=20report=20abuse=20here:=20https://mandrillapp.com/contact/abuse=3Fid=3D30504962.16be245bc6504bab9eb1305ed5d9aa1a?=
X-Mandrill-User: md_30504962
Feedback-ID: 30504962:30504962.20250314:md
Date: Fri, 14 Mar 2025 18:34:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.2.136.29;
 envelope-from=bounce-md_30504962.67d4769c.v1-16be245bc6504bab9eb1305ed5d9aa1a@bounce.vates.tech;
 helo=mail136-29.atl41.mandrillapp.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Mar 14, 2025 at 10:33:08AM -0700, Pierrick Bouvier wrote:
> Hi,
> 
> one patch is missing review:
> [PATCH v5 12/17] hw/xen: add stubs for various functions.

My "Acked-by" wasn't enough? Feel free try change it to "Reviewed-by"
instead.

Cheers,

-- 

Anthony Perard | Vates XCP-ng Developer

XCP-ng & Xen Orchestra - Vates solutions

web: https://vates.tech

