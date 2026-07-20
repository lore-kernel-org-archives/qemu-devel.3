Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFB4C4451B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:12:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlj6x-0003m6-CY; Mon, 20 Jul 2026 04:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlj6v-0003lo-Rl
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:12:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wlj6u-0000El-9A
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:12:25 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K6RiwV1774889
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vm7EwAewzb5dqTdwtVZpGzLsVFm8DafDDe4fNtytAGQ=; b=TZS1mX0esxh0cCbt
 XTOv+0YUOlV4IJepXxTH4S+XazY9Gsk3+wWeqvdMfgKp1kpW/3TrrKKs/QEfvmh3
 z9sA06KnAy+jK4x/D1kL3AXSjMDuNum6+lrlmw/Kellw/Lgk5b+JDVrqOE+cWp4I
 cd24aiO4zkVwF6KilPScEMbDNn8U8w1R018os2xoMUY0YwAkDL1FbTTMKMItwt+S
 wotPIW2wvgSkQQ2G5GpkAdaiP+5vwmf/9SVJ7Njw82r4hucQUrdUyEsmb7k+p9gR
 DR7KgTI+I7pZIS82czWg5ESm1NhD3duheewfVPdhNPsXtMl+8xRIP69Ufm7FC79q
 73R6oQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2af548b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 08:12:22 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c20762d21so90669331cf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784535142; x=1785139942; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vm7EwAewzb5dqTdwtVZpGzLsVFm8DafDDe4fNtytAGQ=;
 b=fLsZhkGoD/G56g2sMlv7hihvJEulRYhWZUQtqB536Eh+Wgafe3g26MLsfxVUxWDBhr
 lkcF0GSMMynWzq6XtnDNW+CnwCOT+arEe7MP5MpTLbyM7Rxa44LncJmNNpeb81UKUExy
 VtQbmMgWM1gAFyhJEPh5HpMclJqZJ5cYi/eATAEX/7W5h1PB3P//79FbCmdw+ipVjQAq
 QjD1zpll8O3gslFp0Ud7v6e9yTJl7dihgaq7s+7PJesWW03+ciEik3rN93Avmz3nYdMq
 kKYG2D3FFJiAF3OxKazI6ScX5wK19u3WGUXSPnXUnIS5rlu52CjjUnQ5jKpIgRDbRw3G
 zDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784535142; x=1785139942;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vm7EwAewzb5dqTdwtVZpGzLsVFm8DafDDe4fNtytAGQ=;
 b=JyHujGIXELJzeZHOWLmpvLQ5c/JCKfKONr/ujv+y2x8/60VH0TfwKmXJeH7+XxKnuZ
 XO4xuXOPxS79s3eqU04cCGL3pAsnt4vip30o9gr81MyyEwYzPnesZ7dXkoCqK/gle11L
 NCyV90gUZ7lwac6qmjPMNqaWcocWVOZ/Oq0HWC9kkJZCgCq/16045zIE/4JT1szSwq3+
 xtGijzTKEffi/JHWFd6sGovP9EjwSH8dBnF9CYvx+JEISVvCyTlbdpMQNbqNaTZcWjux
 AU0O6O1DDJWqOw22DzegqSOhRPXrE/Cn8JH+lYephg9uWuEC8TuBfavg1rCALLRCmE1N
 Osuw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNbwj1vXC8dhmUpUZsosa4m8PCFKHdGVlCrji/oGimFnuFPiJidRmdary8FUt+GGCps70ZxB7HOzuU@nongnu.org
X-Gm-Message-State: AOJu0YwQtpM64Cyx+4a0lVx54+UTHL1aD7SI3DkLjkv9jVlfVr1yEJwe
 hZh8MTTpNj2vDZGlSv1PVegn31ADTmZ0mQgxapenp8j2V0srCI+oj9EQtKm/bZRjUUFKAAfwoc4
 booyFVNRuFy55Pe7ixeZKlgzEn+1Dt/EBSkh3Y9g96GFmFhauR7V1hyWw/A==
X-Gm-Gg: AfdE7clYsAvexBU7P59TiPu7XShi5/9YgCb95CxEM7HXa/a9rMu0QM8cdJWgKYEkFqF
 BoQk9edagcRPnXf6kNvR1cbAxDOmaLhU1xGCvTZk4Rj2aNGA2zl/juRjIu37iZezWnQ5BCSc9+i
 SJmZoRfdLV0CT9f3x7aEUxcSe+AZxZVm8Nnh8dNIxSjddQ2NyjqXVdxwn1p1KqKIHOa6QlgUjFK
 pKLQ3lDcR61a9tk1yXzQ4ElqF9RejGt8D/kRNXHBKuc559oIr4D/FwwvjeCFV3YLQKXs0BmH+93
 KWonF1V7JAx8tBOTxBP4eI2aDVX0xeBoNlzjjEHOGhVVF4VODF8srO32X33cn40iE6XemHN4b2j
 p8ppOmqTXXm9I9glt0bF4Z7HJmTSYg92zHCCyvQhXKebJPpnBGiY=
X-Received: by 2002:a05:622a:4188:b0:51c:1f97:e860 with SMTP id
 d75a77b69052e-5213c10a76dmr121835241cf.3.1784535142191; 
 Mon, 20 Jul 2026 01:12:22 -0700 (PDT)
X-Received: by 2002:a05:622a:4188:b0:51c:1f97:e860 with SMTP id
 d75a77b69052e-5213c10a76dmr121835071cf.3.1784535141727; 
 Mon, 20 Jul 2026 01:12:21 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49548e0fcdbsm221500995e9.2.2026.07.20.01.12.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 01:12:20 -0700 (PDT)
Message-ID: <1d7252e0-3a09-4043-bd5f-9ba0aa1b23a4@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:12:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] replay: fix use of uninitialized pointer on error
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260719113216.1177594-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260719113216.1177594-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MCBTYWx0ZWRfX9n1ZncjpkzRA
 zIfMKBHbZJTeKJ5Ho25lanEfOQjJKJdKUg5UVHHyIO9TBh1rNxaSVuPoGd1lax440TPE7OwgbTb
 l998jtw0FVokQZ54BqWfVP1WwAmU43U=
X-Proofpoint-GUID: gtjWcJDNVUMaT9Turf0f1LRqb8v0cnbM
X-Proofpoint-ORIG-GUID: gtjWcJDNVUMaT9Turf0f1LRqb8v0cnbM
X-Authority-Analysis: v=2.4 cv=a+sAM0SF c=1 sm=1 tr=0 ts=6a5dd866 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MCBTYWx0ZWRfX+2u9gdJm4ZYI
 xTv9qY7rffbqXD4dy/c0jdF+Ars4fs3IiDQyLaH//25LnW/syiEnEjozmWs25plFv+mdDlAw2rB
 bHMigNmRAymoslDS/3ZAjbilHyvLAG5Zmc65uGycwBuPpIjzt2uVHj8TQlmuVtp7Se1oTjnBN0r
 qZ7ge3z6aZRCxnt/NdynjRgi5gr2a0ovi2HjDEX46dyvmktooAbiV1Lm5SvILqiS93j+ELKr7Ck
 khGc01lOJ2Up1loyVAMmz8pgxLzQDPyxUXZcE/nXERuQbN0Uif0RcKbYaS1wkNkT+CQRJjgm6w7
 fPDytcCf5bir2xExGljtsGCLdxVOxu6aleFXT14fe9A3HIRnvYkl+FGCi6twwHkA7dlXWiOnCzx
 faI0UHVkEeepGL/MZrH+wAsW3YAkgA7MAabIEHKvbuC9AUbbX7Oqu/eFcNW+/c8r0sGlroQzKPo
 KBpvrGxZiG+W0+vQyiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200090
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 19/7/26 13:32, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> When bdrv_snapshot_list() returns a negative error code, sn_tab is
> uninitialized. The loop does not execute (since i=0 < negative is
> false), but the code falls through to g_free(sn_tab) which frees
> an uninitialized pointer.
> 
> Fixes: f6baed3d1485 ("replay: implement replay-seek command")
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   replay/replay-debugging.c | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

