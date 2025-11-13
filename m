Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036C3CD6E73
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 14:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJYH1-00069p-Q0; Thu, 13 Nov 2025 09:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vJYD9-0008Ry-19
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 09:22:17 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vJYD6-0005m5-NJ
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 09:22:06 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5ADELiKE075197
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 13 Nov 2025 23:21:44 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Fs84V76d88P8MgOF63FJeRXueWtolxHjS0mBClJAG6E=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1763043704; v=1;
 b=L3B3oZMttB3tGp/6aWBhMpXIjEsbeSI3O2DlX0MWmNjvs5CP/+Q1MnetZweD0lT+
 KmRNDcvLGC0LihQZsVU0BXfiGkpKKvHfYM/IIRf1kvB+oZiuWug9tWRq7WNjHqFJ
 TPn/t3ePfY4eVrv00nlR+S2P5ERCTEjJ8fWDijd02pbF4/FTkkBkxwBDdFboTNQk
 TD6DYO0c7enVD7IHXo9xe2DSdXn1i3sWcbEoUvHu8qfXGGLxKeE+sV6Z1rm4sXrm
 JFcSOBfY4/zu9TkrnM/6AyWRlj5Git0WH3PTMxRwQwNS9OtPoUKbFhtESvAlbTdi
 2bAGQ2mlKnpKRk91L1u4sw==
Message-ID: <697b5e20-3e67-42c2-bfb5-b92ff9452ae9@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 13 Nov 2025 23:21:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/functional/x86_64/test_virtio_gpu: Fix various
 issues reported by pylint
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20251113114015.490303-1-thuth@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251113114015.490303-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/11/13 20:40, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Use the recommended order for import statements, specify the kind of
> exceptions that we try to catch, use f-strings where it makes sense,
> rewrite the vug_log_file part with a proper "with" statement and
> fix some FIXMEs by checking for the availability of the devices, etc.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

