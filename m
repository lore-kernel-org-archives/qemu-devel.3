Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88CAC61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzzop-0005Zd-Hp; Fri, 28 Aug 2026 12:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzzoo-0005ZT-Ir
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 12:52:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzzom-0000Ku-TX
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 12:52:42 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SGJxNj3568393
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 16:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Kg6UESLRwj3FWNI38cBsKhvt+KWlHcUQ6s2OTxv/v4E=; b=EB0k9cy3/t6dS2vH
 AwTUBqbCN13esDleIEHauK0qAPOo3PSxor504K3yqLhF9BkzAd6MXWOKNY3Ww1Qn
 nFQpnWsGGHOu+4sAoQgb1nQvwE1wSZSuyNo163VEN1GTp6TEt4FBsxoI+2+Owuat
 o9lh9CcP5Pj9H9cSWAxJi8F+z816R1/NcSaxSRLfLYqy51HuS3kmi+IhFKG0/d4v
 Y2xLpYIHa5FvVUGmcTgDXefJdtjtAmOWFrBDF0d7TPjoF259FGF9Q4fxXtXWUdFg
 VTJAzbyq8AK7dw3uHnm4aMdbfyPfnaX25cjXkAviPhrSZuVe/PAcn/lb3vMv6m4m
 UAFmrQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3mxtrrb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 16:52:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52fc0097865so21853281cf.2
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 09:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787935958; x=1788540758; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Kg6UESLRwj3FWNI38cBsKhvt+KWlHcUQ6s2OTxv/v4E=;
 b=HrERH+ROUNoNjbJkJZ9P81BdQrKASkJUxr2OW833RfZKC8Th1n8ZRHi8tja4MQkDa5
 h70LgVQPunype1vD+WI5oEZEuM5SaOmDSXGhsTeOUr2vn5WfCftcHQHZVNUvxHQbT+vz
 4/CKbQJfx2UelxP1jvzZtw7cz0X/BUvC6wmZX0FbQJtY2h5T5cnlv21nKmlaV9LjI3KW
 +UNQoaoBbkdrGevNWcOTjOko6wVhTYBTV8Ir0hwcDzG+rH8mQHNJdW9F7pJF5pN/941d
 ssV/LUtfKfZ2vRmLbvSl83a2vvitIJqSJ1+ou03P3IYK/vbnSJX3gSmV9vn/84LaegRn
 9J9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787935958; x=1788540758;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Kg6UESLRwj3FWNI38cBsKhvt+KWlHcUQ6s2OTxv/v4E=;
 b=leSLrd3F9vqo+nb4X6Kd3NU4JNH+iux6DSayH4Gd8jYvnjCc0yfC/nah0tM0v8PG7t
 C7P6jytPV1D8/ka0nlPjrRYpVZqlQfHTGTeOApKmOMgQR/2UqBXDk5RdZH3nQ80kEObw
 ZEgq2xgiokoZPVTce2Xome6ndlldcjD3VdmtZonpUJMS9SLU3A1O5ZNWjnE5cTrHckEM
 DPcX2SqGkns4wdrPNUCTDxNjxHSA/xVFGFQy+SyOo38VKiR8MJEsTI1FqdGbDzJzccJH
 WSKvRzfvtgnylrCpElWrv8JEJE4FFeARnBxjsqOvHcnF9e2siS9lNkQfMSJF5+1B07Zx
 5jOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrmAfDjpcoWTR8Iemfa2KhFza9wqheRlD+XdvNwfqT6hLhTKn8mGBmHB8Bdj+fWkUpM1IB6pdlZeUx6@nongnu.org
X-Gm-Message-State: AFuF++maETRqJpz7igbKe1HqAfq+ux2rh1SUxvESJd0ktBOzODsceP1t
 9bzfm/Ga3DoOc14b8x7FzqVw/KPYajiqJpGGWxbNmah8MRgrWpHxVQoj4Xoke3taoskMWymY1hl
 k1GblNpKYIulafFtZnhPd+xbfwwP5k+sytloEOrZj8pqt7F8IWJWwEgvZ2w==
X-Gm-Gg: AR+sD13LPKkaXJRlJiZj3NoeBl0cSXMK870Ud/cYOKW7l2pbopc0TS4zPmmm0z8XBWt
 xx9xwNjsODBPmh/YrRm+4hgSyK0JWZdWHh9AyMGxQWlLLMNnwaM9hSm+AZHAKcXWJkuK/H/UOLJ
 lJSHEbQ9mxp7sxF9aYpWRd8X2Ibt6JNKPoFoi4KBXjc4pzRqOhWmlmq1Yw00SRRCk1VC2GJbohH
 AMN+cMfVWDZW8PRERo2Ppk+hErE/tnkz7i22Ry/aFgm5+2Fjwj5m5iEFfBU80wKKT8U2+wAKXki
 SpL+QqmNCpO60herfhSnWLKvqyJ7FYTQl+G/nZrjCb7v5Qvblr61CxoseOtgArsv7fRYQojCfTu
 HaRJ/vjHa99yYFmkT6wrCfe141vz6czVP6w==
X-Received: by 2002:a05:622a:1109:b0:51c:1590:8e13 with SMTP id
 d75a77b69052e-52fb93d2796mr103586541cf.4.1787935957829; 
 Fri, 28 Aug 2026 09:52:37 -0700 (PDT)
X-Received: by 2002:a05:622a:1109:b0:51c:1590:8e13 with SMTP id
 d75a77b69052e-52fb93d2796mr103585721cf.4.1787935957260; 
 Fri, 28 Aug 2026 09:52:37 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20793sm4727178f8f.17.2026.08.28.09.52.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 09:52:36 -0700 (PDT)
Message-ID: <e55988ca-43d0-41ec-8a3b-d839e8138461@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 18:52:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/50] Make HMP optional (and later standalone)
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, "Denis V. Lunev" <den@openvz.org>,
 "Jason J. Herne" <jjherne@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDE0NiBTYWx0ZWRfX2WtyVmXmxgTC
 mrp1RJKEvdhiv4wriTog/uDCvEpURZcxNtI6TOjnetkhipPIPsgPrD1CBrsd9J29K3bxIT697xV
 dPnp33MIBwVSNhYhnEDHFaY9rFfX8Qq5JayufTq0OS10byyZUyBOb6g3SqUNuRl44LEh876ke6P
 nzASqjCefBRkLdDTONGCfWcA7nDJurjR+HW0/FPWrAXtoBEf5vAe+NQZQThk5p3xwjd/nrBEgUk
 VyK/X0ipTBULT1qoI0gvnxI9blDqhWDlFKD74jFLbR7JKtl+ezHcdgP75kQ8G9l4RuRL1LnuB4t
 RmZU91a88vE1rylgk3IFTxgVf0LN1nraRitfqM45ayFRrnjQcDpl6aV91pS0qJ3t+5ztXLlvyNA
 OL4vNKnGn7U26bWoh9XNM1SO2p9TSoVuSL1EYmqvnATLHASCAnbvU2cbM43Ig5Z/RR1QWgGGHQv
 O8aI7cW5P0e0Ceu57GQ==
X-Authority-Analysis: v=2.4 cv=MONQXsZl c=1 sm=1 tr=0 ts=6a91bcd6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=G91jXg4iDfnOBt3sguQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDE0NiBTYWx0ZWRfX+/lL21TrvMoy
 9FXfZQ5q7d6CovL46A5SNyTgO4pa1kkW6YnJCpJ9yJOq4JMoII6R4LET8fQmWCxhV7O0X7B9TOB
 klpZR4lqPAkn50Bq0Yq5Tc6Tlgsi3bE=
X-Proofpoint-ORIG-GUID: S1Iyu3Za4Q_56SFgMa9_EwY4qXwMWJD5
X-Proofpoint-GUID: S1Iyu3Za4Q_56SFgMa9_EwY4qXwMWJD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280146
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

On 28/8/26 14:03, Marc-AndrÃ© Lureau wrote:
> Hi,
> 
> This series makes HMP compile-time optional via --disable-hmp. The
> resulting binary speaks only QMP - reducing the attack surface, binary
> size and enforcing a separation between machine-readable interface and
> interactive debugging console.
> 
> QMP offers almost all the functionality HMP could provide, so a separate
> standalone "HMP-like" console could be implemented on top of it. The
> rough list of missing commands (+complexity estimation) after this
> series:


> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
> Changes in v5:
> - renamed local variable hmp_mon -> hmp in patch for consistency
> - renamed error_vprintf_mon/error_printf_mon -> error_vprintf_hmp/error_printf_hmp
> - simplified default_monitor init with IS_ENABLED(CONFIG_HMP)
> - added early NULL return in qemu_vprintf/qemu_vfprintf
> - reworked !opts->has_mode path to use explicit error_setg() when HMP is disabled
> - split device-introspect-test patch
> - rebased, collected tags, all reviewed, ready-to-merge

Thanks for the final polishing. Everything LGTM!

