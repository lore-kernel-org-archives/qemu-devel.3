Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3554CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waDD6-0003f0-B8; Thu, 18 Jun 2026 09:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waDD5-0003cX-2x
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:55:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waDD3-0007V3-9d
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:55:10 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IDrdGg3009743
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 13:55:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KqZjlf0TRXAW/tJQRfsiDp7HFbWZvJth99+WdggpK/c=; b=kpleRah1zWVqiRmm
 4QcdP4aCRi3l9s1sUv+DDScV8+HChrKESog2E0ce1alnPjZaaJjUhHL0p+N014NB
 MAMZ2awjx2NB1kci03dSsStG7DDrTZW/ZB6FnkHgU4BF39NeEEUFNiBwjmMmuHzo
 0viX/tE9xRcgrJ1IyHt7KBOOpTE4hFoOpjzGWi117NkPcIKdjY+ZoF+o/NAjK7tb
 eyijrDvXQqLD8EYzk85xnn8PzOuggyHdyqjtNibo72a0ndhHj8kdPrvHHc2lprmD
 zQwHyJzyruSA4uGJoPVQFbopIVt1OlP9KjQZRoCNBnqXuqnCkFXcWSfY3yPkpe5S
 udfwnQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evgtmg9cq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 13:55:06 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9157f453a27so204686585a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 06:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781790905; x=1782395705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KqZjlf0TRXAW/tJQRfsiDp7HFbWZvJth99+WdggpK/c=;
 b=bm8L619Fu7AOZLxyw7yLaOQ84UH6skzbAofrTsrhYOcDBaVI29hzIqun+R974kZ4sx
 2jUiMZmTzgz7r6cwPBJb9iVW5Gtmmso9s2gA0ZqS6Vrk+7lMltlt9MjX5DGMYrMzCqAu
 9Al8ai4z4vNpfC1+8MsvKQb+qF8equLaf6NkXtmERw+B1CZJswCv2yS4FXOXj1TMGbhb
 ubRzVstEcxbxGrZkvL5bJXfd4TAK/AiLZUUai9AdGKKcckYkyR5hL2Dq55xhtTjnz/uY
 hg5wpf5PrXHI5zm6UQBDHtfFJ4ZIhpblp6MKlkiOhTQh1I/82mtRIw6WdNamwjvpEzIs
 v02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781790905; x=1782395705;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KqZjlf0TRXAW/tJQRfsiDp7HFbWZvJth99+WdggpK/c=;
 b=qpVFXFN9aTSSe75YhVPXAkAiAb7576ueKREdiF3+35eIIP6oKQpVqyoUh8qRToyX6h
 dT+3hVWPPnIxbeJhC3JYt77sjF+YoRPBcNyw7y4WJLwWYlbndEa8mN7TCTs1Q6vPSUAv
 gtifiRDLJZN9yJ5yjA/Jn4p1MruaonhHIWW/xv9GRHQqI5FCoe9CwWGsc7WhuAwx96zT
 7skW9AhAiuKSYby+nLBtjo0/aq+3GgL2LJuAA8ZTRXzAGCp+aM/E9ckAGZ3tBJcPI0ov
 AFEseffhmO8iGc66TjMROZ/sKFUWVbyy6IdjGLMgjO4AvLpRwF9jF81Cjdh1vcAbJoyg
 KyPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dmiNiUEfumQmSNHEAm8EhNYlCKl9LsK7oWwwKcKzvxhK6jsllBiV/oPasxC+mGNXUClY6ClCCt9aD@nongnu.org
X-Gm-Message-State: AOJu0YyOSRhhQx1fl37j7hqjh2hmdQzoXAOykwEHQPoX8IhE0EZ9aQB2
 BDC7odCRpGeZ1iCAnhdecFvvpJirjIW7XTZMT8zw3CmlIWHuM/NDn0rLgYjl4LBOfwtypQmowlp
 4uB84KOJQFDD72+V6z8p4fRoMdAQ2KjWf0uR2ul0Abnqw97q8ZckQ/5TzUQ==
X-Gm-Gg: AfdE7cmhEALmZs2PvRRUgBwixvF/+Hg5xZFsFZmCGx8fFt/AbJbbfZXnu1qEwZ89Bg3
 775d1Ls3+UD93ziEpJrYVALrFXaJDf/Lw5NZbcNEzMXEL3xXU4tqCJ27DqnWMUV47urlaJV9wUj
 DKsDJOxexgMq1TUWXngSK7JyraqELKi0AOclTugPBYKjb45ubBWnPsSMZ+FEErO4gt86xMY2F/w
 9Woh2S86S4ntIgSRsM16yoAKgIIHyukpiXmGGYs9dcwwur4xEOc04NjXiBE7kzvPVO/CN8WFnK9
 MNfmYYSwhogb8P1CR5PHTKc7P5kNtRpx/5U9v2GbjaGImeB3xkhyeWurd9gIX7sk5KBLOCPKVKJ
 1lvzV+CANnb1I+tAVzTwAoozLtIcp8R9NSLlZg/lOIPEloRmvdTDFE3pyofXb2Q==
X-Received: by 2002:a05:620a:6f91:20b0:91e:7a20:3cc9 with SMTP id
 af79cd13be357-91e7a20430dmr726206585a.52.1781790905501; 
 Thu, 18 Jun 2026 06:55:05 -0700 (PDT)
X-Received: by 2002:a05:620a:6f91:20b0:91e:7a20:3cc9 with SMTP id
 af79cd13be357-91e7a20430dmr726200585a.52.1781790904834; 
 Thu, 18 Jun 2026 06:55:04 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263945sm65759439f8f.8.2026.06.18.06.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 06:55:03 -0700 (PDT)
Message-ID: <fb16363c-8202-4b82-aa80-db29ac623fb6@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 15:55:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH v2 1/3] contribute: reformat/restructure bug
 report guidance
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260618132058.1044341-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2waxwih-OzP741W49okXeTKPPChcBjM9
X-Proofpoint-ORIG-GUID: 2waxwih-OzP741W49okXeTKPPChcBjM9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEyOSBTYWx0ZWRfX2EbLDHgGehO3
 V4Ko+/Tcc3EuPMqbPABHj3zBFr9IOEi+ETQRyoju/WhIImReTClHc4dP8lFlLRooSUwJ7tmC3T0
 WWP/m0IdwhQFdK5FhG0wOJ/ERav8uyY+UuhWd/RlGseQDFZNDruZwM33ji/OddR3WkKch+0Ej4J
 t6iJrrIWGTvd+dhRRk7ZSbOKDT+IidxXcNIxe4TUQWfVGCsQsvZ3GknxcXV5YGv5DUaiUxeFkW3
 uevMi/qK4RloCGQQ9x4r14QJPaWisbJn9ZqYUd8lN2yo49wjhTiRrEwnvl9SHrpE8VI6zaJtXrz
 lP0uj1yRK7L82NEhYnMEOqZzpXO/qzTrjIboeJJ98neI8GwF3AKdrE3b0OFoF9Cjo6Z+6iA+eqV
 56tBylJX1WO9M+jjlMrXw5TYnZLPtn9KPWJ9+GoxgbWNRXdqnq3s7Ho2cc2gn+LPOa0FsWyJObn
 qFnqawHYBRw42IR1eaA==
X-Authority-Analysis: v=2.4 cv=Qb9WeMbv c=1 sm=1 tr=0 ts=6a33f8ba cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEyOSBTYWx0ZWRfX40riUX3G+SQf
 2yPT4G3OUfP6OEvvRWIew3fo/dfyo8DaSHpE7ckU3Pik/XiX7R1gewek6nigkUwKdevA9ibCaij
 XmqLvfKeAy1XtohSeIAzEZg4y7GAgwI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180129
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 18/6/26 15:20, Daniel P. BerrangÃ© wrote:
> The current bug report bullet points are duplicating an
> arbitrary subset of what is already requested in the gitlab
> issue template. Rewrite the guidance such that it refers to
> the issue template fields being required, where applicable.
> Restructure the text in general so that it is all a bullet
> point list rather than a strange mix of list items and
> separate paragraphs.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   contribute/report-a-bug.md | 55 +++++++++++++++++++++++---------------
>   1 file changed, 33 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

