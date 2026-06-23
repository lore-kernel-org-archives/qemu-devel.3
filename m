Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8666DCD98F2
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc4jb-0006vu-Fm; Tue, 23 Jun 2026 13:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wc4ja-0006uZ-9U
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:16:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wc4jY-0005Wk-MJ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:16:26 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBYk8p113501
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xYyOiER872ylJaZUgV5sxNWc64Hk2sNgoDSiSYSl8ZE=; b=hpzdXlU9wG7XRzoT
 0HYfx17Mgk4S/kB7vO+KZjE4QbewEMvzEQ7iZjTJsqvGZREM3RM/wFIQPqYCs590
 OfxYS0MCiK9YFrXIoZ6pqkkkhTswNY1jj9yu/Ukx4e4OBcGCd2y9JWu7r2fxEy03
 P2SK+dYkdwg63fsuI/5SFlFZA1XwOCJshev4OdoZJOGHZhTHsON8AxgRCVSwWrnL
 YIEML5cDygVVGAj4aOk1ZnlqOdZzhCpGTMJwWijghN01X4DupgkIZ4YBEk1wkOy9
 hnRM5+nzppSNyzAckvMAka/safdM2vCT76J3VuA6g+FXS2OqD1fIXEhtRXsjxxtA
 Zj6yHg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eymnvtqks-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:16:22 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c13bb8ca9so56118eec.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 10:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782234982; x=1782839782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xYyOiER872ylJaZUgV5sxNWc64Hk2sNgoDSiSYSl8ZE=;
 b=SWLkHJs6J+2l1eleUzsnAy42KX1VghuTJhKcqH2anbOjZLplWYsC84iArKkH+KQ2p7
 ntGiY+xUyLtf6VNTwcaYjFWQimePj8t2F7j3nVkwOs/MT1mWXPqEi+D+X39TQQgpaaHf
 n8Imv5sk1YH8Z+CBQaoOnphfZgtPoqnjPNzfZBvodUmzkFH2h64qLygffqNqaxhfyPkE
 awXjIh9XP0W0/TCt10Zb0poPJyAibP/y5gy7MwG1jBJhqHmHjMZBiKRxc/nbGR6+YXP8
 rqdhUYpInF+p9hx/z7uYfF7l7d1feGfMqKuj4BAUzNWB4jtG07bsMtpRDSCbauJq6G3a
 fjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782234982; x=1782839782;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xYyOiER872ylJaZUgV5sxNWc64Hk2sNgoDSiSYSl8ZE=;
 b=LNfZLAKjWcCL+RhewFxuZO7WsZHQ2DQJcHw+esxrqa/aRaVmnNgv2uJECSpaayE50r
 DvKeTGHdoK/nWd/7onbyL4YJcWNbY8u9LxfV7VkeKeW3JsKBExKlHSe3i9il2aBCFDOW
 ERLQ28skHut0NRusP/1IaRJca2X8ZN7Lu/aBBheCdasO96k5QREpPefVRUWKF6xxcVCL
 3KuUjAItT9luqKH+RtwmmbaQI+Jj2nvAt5Hr/CtgN+t4SyzuIVlzZdhxGoZlNQ8yU50V
 czWeDpI/tFq1UlRvGKY0+2L2ZxTO6Ntoz/bqdj3abUp8TmwbRRst2Nla1FqZlrQlJSUh
 9ehA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9pTb4fmy98tMsduB6cZj9FiyY4JCRReZ/2nuN4OlNEadFdJYSXAOTKxIm9yHNhgiYjkQmufGZOsbi6@nongnu.org
X-Gm-Message-State: AOJu0YwSCJtpjoYZEyaSkOzYWIDen5bBV0VR9wxh4bsxCpHCxXQso55N
 pzdzMObi+hGUrcpr+x42oa3pKK0kdQU4R/dwzn0Req4cSFTS/ba3UZX+gnB3iblxa4j3lK3xreP
 k7bWuntYOhzYI3no5gQRf1ul5k0A09O7967JJHVDOJl0ShsArSBDYOhERRw==
X-Gm-Gg: AfdE7ckZy9mg3JMa4N5QMyjZ3HFT0SQdO3y+jcgHbmh7hHPLcy6enXK9hrhtsPiYwfT
 IkZtv++Crt77PQ1BI44vz6/QApixPZNXXYy8Ndu/K4ieSejhrOA+jV9g9ALAodU+g05JA5O9d5B
 cwvHbvn+i5UtSHgsp6QvNLRM88J+EZGNqtvHWuLoiTDvjxZqhQFib7JECzUhVgUrFX/NVeU26fk
 P4YabqIr6mog/BthuOf8BoOYbArB3lYCnONI3xWjJ7A6RzZ7n/bf+P++MgXOnLV+z14wLWi2gzP
 BvnSwk2jVDfxC7BdQ8LH8cTc0P+RMjdnv2ubwplmLEMr4Hb8zSO/Yv8+jNTSq00TMW45+xaTo1v
 2hhuRvATxneClF7Wo9QXLGPFLyLi6EleklwU1Z0R0Ns5RWe+GOo8jc2kjBqmpKsvysvBdzap/Ds
 l3X54=
X-Received: by 2002:a05:7022:f689:b0:137:f4ec:29ff with SMTP id
 a92af1059eb24-139c6f42e38mr2381956c88.22.1782234981786; 
 Tue, 23 Jun 2026 10:16:21 -0700 (PDT)
X-Received: by 2002:a05:7022:f689:b0:137:f4ec:29ff with SMTP id
 a92af1059eb24-139c6f42e38mr2381906c88.22.1782234980858; 
 Tue, 23 Jun 2026 10:16:20 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139adcb7a94sm14016922c88.4.2026.06.23.10.16.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 10:16:20 -0700 (PDT)
Message-ID: <831eeb2e-cd0e-4b47-b573-f5f9bf31ee4d@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 10:16:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] contrib/plugins: add dlcall to call host functions
 from a guest
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260622163438.130746-1-functioner@sjtu.edu.cn>
 <70f7c4f9-ab2d-4a5a-b440-0599b4c16242@oss.qualcomm.com>
 <06e6901f-0f45-4f01-bd06-eb1928548367@sjtu.edu.cn>
 <9cbeb740-405d-4738-90cc-fce7eca7d9ec@oss.qualcomm.com>
 <fb504309-4e3e-48e6-9e33-108edbcbb173@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fb504309-4e3e-48e6-9e33-108edbcbb173@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dOWWXuZb c=1 sm=1 tr=0 ts=6a3abf66 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=RxGbqB6xSX5Uk-Q9ySoA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE0MiBTYWx0ZWRfX7d+Pvm3SWrPM
 Fq4Bbg320hpN0FvLWhX3CGklkZ1TAl1WYPSpqqAeYvKSKlOqx8eNsp+E84e018j3R26i2ojlyOb
 y6gMOYykRm+e/ClB0EDmbcou85OLTvw=
X-Proofpoint-ORIG-GUID: dn0fJ_UtJYy6NHCKSPGRv2URYB1oqr5U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE0MiBTYWx0ZWRfX+dZ84jV8Yzds
 78G+gD1pj9XTp1vHpqDwdw3nSCwoxeqGFcLSDXlPDfYdiq1C3smumm8pauakOjEmeA6urlpFUPA
 BoBWRwS7kvaWaU2i0XhwlEIHi+kMuq0vFjEA4HCHL3tYpWQux2yc/V3CtefRMPvP+MWbzUASFNF
 Jy0N4XWR9aCiQChnOutX/Fl2T3Den1ZZSKVXKSlsA8JGGYBzVdPmseYv+k/cOcc85S/8XcOf06x
 4Hsh3/VgaubWRwrE8JvzM2L9e3luaitJv7cgK+K2xU0+wvXhEihTNka5LpqspkcnpHKO4NLtE2l
 ZTKidVa7CzHvp/kulIQEVA7ykqSYKWbXaxizkleZxRw9t+sybBeT37X6p+263CeMVxFXStG2tpp
 ej5IOHw+26N7SwoeH3LCBcDC70P5tIt5WMI/28LgVNhK5HU3AEN35j+nZxXMlCshHNmbv2YpEcR
 yEkCUg0sLzcLlORQSRQ==
X-Proofpoint-GUID: dn0fJ_UtJYy6NHCKSPGRv2URYB1oqr5U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 6/22/2026 7:51 PM, Ziyang Zhang wrote:
> On Mon, 22 Jun 2026 11:04:43 -0700, Pierrick Bouvier wrote:
>> That's my point. As long as Lorelei is not a stable tool, we can't
>> really integrate the current plugin upstream. However, it's great that
>> you posted this as a RFC, as it shows the approach work.
> 
> The main reason for Lorelei's instability is the repeated modifications
> to the plugin API. However, this current PATCH indicates that the plugin
> is at least stable now. Therefore, Lorelei can become stable very soon.
> I will release Lorelei in a few days.
>

Sounds good!

>> For now, I think the current plugin should stay downstream, until
>> Lorelei is officially published and people can take any library and
>> compile it with it. Once we have this, it's easy to motivate integrating
>> this plugin upstream, as people can do everything themselves.
> 
> Since the current QEMU does not force the guest program to load at a low
> address as it did in version 9.0, the callback functionality in the
> earlier versions of Lorelei was limited. However, I don't think this is
> a major issue. I must first publish Lorelei and integrate the plugin
> into the upstream before we can discuss the modifications to the mmap
> handler.
> 
> What do you think?
>

Sure, as soon as we have this publicly available, I would be happy to
see this plugin merged also. Corner cases can be be solved later, it
doesn't have to support 100% of the libraries that exist in real world.

>>
>>> Regards,
>>> Ziyang
>>>
>>
> 


