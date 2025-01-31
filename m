Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCE7C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 18:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdvnH-0000hS-At; Fri, 31 Jan 2025 13:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tdvn6-0000ge-2D
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 13:30:57 -0500
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tdvn3-0005F4-6k
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 13:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1738348251; x=1738953051; i=deller@gmx.de;
 bh=NJV/pXRzEtlY37QrutNc3t+orZQwq4meFBb0KlDDB+M=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=WsyCLccS0yFoI5SXX92sj7SSPA+GN+Or4Fd0Iq2t07B6jR8TKkmNNyqf1Zdn8XQZ
 v4dtxCtTLipi/z+4nu3K49hiwuovcC8uz3ioCw0jeP9o/reJg6rxs0I5hN7SMBBdn
 CLlwTt+H43/9+Ud+amnSirNtF2GoQHrs5NqSDo3l71VJKVMxIJMEkZ/MZemDZWmeG
 dPb8uuoodYeJ6WNPcrFzdPElMjG/g61JocklamMTXPgu/65+fvBeiqz25DPnReXpP
 MoNxwn/cI9a7uU8/kQ51fshLnVfBxms5zUrTaDRDEITA7pSwc2P4QO4Gbt7ZNV22t
 0GjxngiAVR9JE3eBPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.6]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGyxX-1ticcj3edv-00Er7b; Fri, 31
 Jan 2025 19:30:51 +0100
Message-ID: <99c444aa-7acb-471b-81c1-653a924b315e@gmx.de>
Date: Fri, 31 Jan 2025 19:30:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add myself as HPPA maintainer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 deller@kernel.org, richard.henderson@linaro.org, qemu-devel@nongnu.org
References: <20250128170914.13353-2-deller@kernel.org>
 <7484e0d5-66f7-4fb3-9262-7d698b2b1da7@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <7484e0d5-66f7-4fb3-9262-7d698b2b1da7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Oh7jMih9y1/UgKH5jqdYe4aSNhQSKutgTCpiy3AKpvgh4ygSbRy
 QQzlSoQH3UCbJr0+BKxoKEMoqKF4CAIjpuiRL06UemAyIT4z0DAQ46mx4gFZ4Wma+JouwE5
 KYK6+vJe7jBc41+5no4t29WYbT6CWQqXZ8lv663oCVvlsS18H/IwtW/qyz+6JHX+9dYanZw
 7KyprYFmzeB20gLMZ56nQ==
UI-OutboundReport: notjunk:1;M01:P0:DAeWOkEPMqY=;9dPVd5u0sj1rLkCELb+vWXr9cTM
 Sd724mIuciicdMMi2grA2wJQvO1fkzx9M9GVRn1+HcBZnZIm9WZh1XwI+tviUza9EDrC+YzVT
 9q4liTO1cVIzL3V7ClVyWUDN2mKNe3Hb2xD2B+h9wTC30dQ29LAtt8gxAALE3sYNOYjTdL2f+
 iyIPMGtjoRn+6bA3/uPVBOtLl+9UraFvjG+Txn1SwIbuUUEPYucdIVGt5wRb9iQ4l2gSJ+jVl
 m+raqGT8nNmfKUJcDS3MMnvjko/q2CkbbPQV+qgxtmLo0mJoN9ppCKKCpKN7VUoUvQgEDL7N7
 jN/Zb+tJPMjzLMLOKwB2Fh0nXKdJfcZGMxzFy+NcL1mnZhyX8YWovRRk/J+6LH53V7Fbdzgrv
 rpQ42O/9aMHuZBt2jvmElr2UZEbD8YHpaD4hTJPBZkQh0CVpN7mVEIN9igdQr9PDkfxOGn0kZ
 0FCsFbyrrPzkaR0DJeGWB3ILHwVU3o2J+d7gh13YPM5VavulWTc4QUjUq/iA2NduszWZ59POv
 UYPn1ibA6RFnljdAmA8aVBG2YuacajbmnrTV/boeUpmwvCWSyuDEwMCSGwde+qyXcRyDwhIyG
 zJKN9ya4+gsNyzmYVxvxx8vvtiqOHAfzWhJnapPD57BbcnLWVAfMUr31fT28xSo7sxl743aYY
 GhjE3+OCpEnjleBoSMN/jMj47FNm0XkuQo7GF93emMBzQ7pYcRoGQmQ1hl+N7mF3F4A4RcQLh
 9npkI+lgmE7ZnRf/Y4AxnkFDTIpTpdYe+J0wDBG1d+fcD7s1i7Fu9rA6yxbMUdrWazgGk4nCG
 CKWBi2fdMGP0ZKsOLNIb9RmA3zxyb7F3Oej/S+yLktF5dbVM96PyutsP+GwpCzXZVym1EW7JG
 Av2Py4Qh1YQMj+mFWwdy5qXvOEcPw1qgoeHNtFBD7O5Ni23Ce/zc8IgufQ6D8eGNM3xw1DlpU
 sL2aobakx3+AroYXixWiWvdMLeF4Ftik6e3xLRAKlW4/ytl9V04hOWfjAuY+MlrklY/NResH0
 vAEPxx8vlkeX7TuIMXfx2TSSsXkjntFRlV7BH7UhM3CbEWF19sTl7woDw6kOgkvyVQ2q2t6Hd
 daDCyMxsB2Ftyayz91WOb/3OApe0+Fje1qPl0OREex0O/itApXeAIdyhsUGYdFRoiYI0QjpKS
 gLga+5XxXuqWXH7Z70/Vs3ZBUnaaNPa3wDTZTY5giwd3L9okPIeabqXwWHv86GJhnVGTZWw0C
 8La25ZaO2i8mlW0w99AIUEC9JgwKRJsxtPedYpN5/nOsMjF2AhpRXA4bjpIgjAumJ/JdL0gBV
 BlAtDTlEV7zuN0ANjuHX2uGy7UjDI3k8IlRW4Kfu6LDg8E=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 1/31/25 19:15, Philippe Mathieu-Daud=C3=A9 wrote:
> On 28/1/25 18:09, deller@kernel.org wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> Since I contribute quite some code to hppa, I'd like to step up and
>> become the secondary maintainer for HPPA beside Richard.
>> Additionally change status of hppa machines to maintained as I will
>> take care of them.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> ---
>> =C2=A0 MAINTAINERS | 5 +++--
>> =C2=A0 1 file changed, 3 insertions(+), 2 deletions(-)
>
> Patch queued, thanks!

Thank you, Philippe!
But actually, I included it already in the series where I sent a pull requ=
est.
See mail thread: "[PULL v2 0/9] Hppa system mfdiag for v10 patches"

Helge

