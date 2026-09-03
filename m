Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86302C624DA
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Cc6-0000a7-Iw; Thu, 03 Sep 2026 14:56:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cc4-0000ZL-N2
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2Cc3-0000ZG-0E
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 14:56:40 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G38pg927729
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 18:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dQ9BnuZ5QmzgOwiAjdsZaMI5EMASpOR6tBbeOiaVbqM=; b=InL61AQXJ5E+64R6
 JF3bl/jJgUmnPfQMO5D8zrbGpap0V0v/FUd0zjs/XKTIwatzkPNnQVcAd1M+/lUV
 WtD/SLqwa90yxWsyD5dLfpcQQAQqlO96zGCurU1fkrk7chDQoVpEr18ZxJt/41+A
 p5GMRNzwuX8mI/ybWFycjck661cb79g6QOHgrM9hDN15SQlmiQg+L+j50h+g3m18
 /HpKdThE2b2opixwdvjRFjLjVECQOxMVhD/h2j0H5R++EjaHrdi2YAtR6WMHZfnV
 nnIyK40XA7Jpi00qRA4wCrFJXnSfFe8f6+XhqmbmoB4jJhkBMVTp9tNf3K5eqdiH
 Al6YPQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx2c4x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 18:56:38 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-398d0010cfaso174395a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 11:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788461797; x=1789066597; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dQ9BnuZ5QmzgOwiAjdsZaMI5EMASpOR6tBbeOiaVbqM=;
 b=NZua6ChKSxvJS1XjOnsr1k6xqYZBQqLcr4T9iVPlNDqvAgEv74jul2AB9LONi1tE7R
 Tag5fWDd5yxZCuKqmby3u5cCqQF+eE3EO8RA/K4ljR2CeO5dd3FtNJVRW3cR4p/YdCsZ
 orXyd6x/tGZ1z27THqFnNO7Hj1mPpg4as00A61ZoPd1jCjqswIbI5wcZX1+cN4kNo2h+
 fivtoVO+JyzHlWmL7iKW29+sm3qPRNTTpWPufMvYxN0EO4oC2cD9+ZE4/Tdz/4fQ7gUj
 CgcJA5fryXeSUP0WOHuB5oiXY3jnzZcQF4S/wwhHuJd1Jmw+tB7yuLqlYD5EltzobGEO
 jj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788461797; x=1789066597;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dQ9BnuZ5QmzgOwiAjdsZaMI5EMASpOR6tBbeOiaVbqM=;
 b=ky27trenljD/W/mWhKjrjXvYT2Pk//fELozrVpwlVXe7vsn0nMwjixiBn95CSPybio
 cewHsvYmmM5x0RajrQ07C8wsxwzIuCBuce2QyOGlf/ZvlwW6uU+hfg1Mim+Ws9vXjtil
 lcd+jKYxJcDL3T/prDYEq9vbiRr+I1fAzunDex1qQ8UfGnqsP4j+fHk/CBJV2IjVeAhv
 wsFeba4F+HFtzqkczLF31oiPftPJZW4/584dCw6wNR3M7m3Nn+g/73/cv7GjmBq6ROxB
 GJKSZpZmtKigpBTEbFEDbjAoKnLyBztnbc3AVOkqUvNYhemFUgoeuki7UVfxk/gpOtXP
 ELJg==
X-Gm-Message-State: AFuF++lyCqbkf3burXZIyAyRhHaHucLBos7s4RyhZf/C/WtTKP/25hmV
 j57IXpTCTqOlVBB5tJF4dyq3AGxc1gUPv7oLCitqZQxuT+gcEdB1vybOiN7yElJhiEBWEokbJjx
 1GWBBPpNrEMOGgSbOg0Nyf+MzOe5nVfcoxu8BOQJXzB9cu5hqWQ/OwOMIrg12/0TBFg==
X-Gm-Gg: AYBFou0+KOp8K4ErbsByVigULWhCLFhh6IdstzbzO8yo1+ZbBu5BTi2+Wn9gUmEX0b9
 1eMSvKN2zWBUrR23u4u4G5v5/l4g6G+jzpjKNcEGbeq35EOkTTDtdD+qsvzkBkY8ckwNOv8YCXG
 hmP1vMIOhrivTvVj1DbOVtz/qssC4jiuQgNpDZETwcxbesWzCMF4fmX9ygxoIFRx6JSaQ1w/MCn
 /8ZSxA0gLgl4GFM+39jm3bYCW2MXrgzE6ydLxh7O6FdNX8emDpHTiDViata/xzKfF81LWpU6xCS
 RH+tK4kz7G/ip+DS1i2de65y+LEFpkiiyQLiETb8mGNfzlDuz3f7l2miNnZjgmJuL3/XCZsf48j
 QvLoascBRhlBgWzq67h85Jse6k/o8SZksakm8vB1YGTOLz2L9
X-Received: by 2002:a17:90b:4a48:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-39b260d2d58mr743507a91.6.1788461797101; 
 Thu, 03 Sep 2026 11:56:37 -0700 (PDT)
X-Received: by 2002:a17:90b:4a48:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-39b260d2d58mr743445a91.6.1788461796624; 
 Thu, 03 Sep 2026 11:56:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339c0ec914sm922974eec.31.2026.09.03.11.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:56:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 8/8] tests/functional/hexagon: update arch tests to v0.2.14
Date: Thu,  3 Sep 2026 11:56:22 -0700
Message-Id: <20260903185622.3234171-9-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: r9mwXRZntpa81Xltwia8vp8PbGPeY3bO
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a99c2e6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=EqftbGKkiOAk-SFv07wA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: r9mwXRZntpa81Xltwia8vp8PbGPeY3bO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfXyohC5WcmXwIu
 1gdWTbuSsUS865n/QPRtOGbSe1SkmkMSDfFVWZu45s3hRQPOfsWYv1M3ylfuwMghdbch/0sUi9O
 vU2SVEccslKWTdBrCj9ZeAxmJtboT2fjr/3fWoAnLHHiNgEz70N5NoEcNBhMEhoXqRxN6fRuYUT
 FPjSR2yUdjL+gyIEs5LyTYPluYWwZm7KWEaUY4/nl6GpkLYDW1whiISvEkMxEAsILqpny52JS/N
 bJiecz48TVgelqjkUhJUTZkzCRW79x2TpnmWeTPL0e9KzyuaJu0GlQep9q86hIwPdf6mYoKy1Ox
 PJnwJDblOvKVz0CC0up7BoVh/cfazZ+qBUR2LoGOcE65mXGllfHMDmHl14CLL6w8W2F2oDp6D+E
 pRN7lI/Y0jFfKuDSGGOYXPHK9wV/PWPH+qRQ12/B21SJaP2Wofu+9rO56OeNyJG6Xl4vry8rOy5
 wcDk0V3GcRFQaICaLIA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2NSBTYWx0ZWRfX9u3+8nSDXRtj
 K+ziQp/wrPILM/Vp4UKK7FS1LRJHZ2w15U26yrjFJBdHsBJL6JiBUgnfo7TnY94QIgOBSluKzLc
 5lE2lylu1ZU2PN7wLsBJLbvHyy+r5Uo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030165
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

U29tZSBvZiB0aGUgdGVzdHMgcnVuIGxvbmdlciBub3csIGV4dGVuZCB0aGUgdGltZW91dCB0byAx
ODBzCmluIG9yZGVyIHRvIGtlZXAgaXQgcm9idXN0LgoKU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2Fp
biA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRlc3RzL2Z1bmN0aW9uYWwvaGV4
YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFs
L2hleGFnb24vdGVzdF9hcmNoX3Rlc3RzLnB5IGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rl
c3RfYXJjaF90ZXN0cy5weQppbmRleCA4ZTcxMzg2YzE4Ni4uNWQ3Y2U0ODc0MzYgMTAwNzU1Ci0t
LSBhL3Rlc3RzL2Z1bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkKKysrIGIvdGVz
dHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weQpAQCAtMTcsMTIgKzE3LDEy
IEBAIGNsYXNzIEFyY2hUZXN0c1VhcnQoUWVtdVN5c3RlbVRlc3QpOgogCiAgICAgVGVzdHMgb3V0
cHV0IHJlc3VsdHMgdmlhIFVBUlQuCiAgICAgIiIiCi0gICAgdGltZW91dCA9IDYwCisgICAgdGlt
ZW91dCA9IDE4MAogCiAgICAgQVNTRVRfVEFSQkFMTCA9IEFzc2V0KAogICAgICAgICAiaHR0cHM6
Ly9naXRodWIuY29tL3F1YWxjb21tL3FlbXUtaGV4YWdvbi10ZXN0aW5nL3JlbGVhc2VzLyIKLSAg
ICAgICAgImRvd25sb2FkL3YwLjIuMTIvYXJjaF90ZXN0c191YXJ0LnRhci5neiIsCi0gICAgICAg
ICI4NzFhMzM5YmY3OGNhYzBlYmFmMWIyNTA5YmZjZDViMjQ5YWQ4MTkwYmUzM2UwY2Y4NDgyODNi
MmY2OTE1MzIzIiwKKyAgICAgICAgImRvd25sb2FkL3YwLjIuMTQvYXJjaF90ZXN0c191YXJ0LnRh
ci5neiIsCisgICAgICAgICJjZTkzY2I5MGI5ZDc1N2MxOTQ2ZGZlOGZlNmFiY2VjODI5MmIwOGE2
NjU0NmFjNTFiMmRkNDg2NTBiMDVmYTkxIiwKICAgICApCiAKICAgICBkZWYgcnVuX3VhcnRfdGVz
dChzZWxmLCB0ZXN0X25hbWU6IHN0ciwKLS0gCjIuMzQuMQoK

