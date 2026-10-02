Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B40FCA5FDD
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCfRd-0006rz-PK; Fri, 02 Oct 2026 11:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCfRb-0006rW-8Q
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 11:45:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCfRZ-0001MH-EU
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 11:45:06 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FHG02896984
 for <qemu-devel@nongnu.org>; Fri, 2 Oct 2026 15:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UNnxYpW6kBbedKuQCzC9M7vUYDqvoR8ieMTpNkVi1cg=; b=K6JXIVduRUoVERrq
 8GyW/gt/QujjdqEmboKyE/VJreAYlXqY4ANebZnJNC0Um3cMs3EfQo5436tNEiLh
 +cPihFYoTUXX+kpxLdn0/tT2cCnDbP3Iz5iCz++DIk9ZfbzfGLvC7UZ6VJir7ayz
 RLip5M9xWZV99tUiNgtxACFMEsju3QKNuR9S8PG73WsWGY66NeYm07Tf55XaJKND
 z5SdSs7Zsw6/oMQKoDAQ2TXyuy79XYnv0tywxlSL7lNH+s++tDFG532F7z2edNt4
 CNd0ImAkpDEH6o63xdu+nH5NYQediXlqlDZsWnNnu8uTFxfNRxdFl7rjeuboDyLC
 fikv1g==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1v0345xd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 15:45:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34d80ca2184so3369433eec.0
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2026 08:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790955903; x=1791560703; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UNnxYpW6kBbedKuQCzC9M7vUYDqvoR8ieMTpNkVi1cg=;
 b=HTYeRGFKDAXgjG5DFiHdbiGkPM6g6lTeHKI55Hn/Lufm36MZTAaXrw/slTho//8WHn
 YKJ8qZlM2sDPpdmlOUAke6xOGyrmmg/HAWKB4Cb873QHbRnFVcJrvk9/LWu0BGEkwpzy
 8clPRiXp2rEEJrn5DWSAd3ybga+i8Py8spoiWslGmYmkFB+MUja+Drgk+rwrVhnXqxkm
 1nLJf/OB9siDQIx1Lvnznp+SW4+ho48W/kS8u0HgY1BE9wSCu05Iwm/rF49sdhdjfYsX
 4oZ5jGE7V4geRoI9VEP8ZPMKpK3ux0nngWCBINzYqW85S6DjUrrwWJof8Ff5ILXwZU+A
 T1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790955903; x=1791560703;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UNnxYpW6kBbedKuQCzC9M7vUYDqvoR8ieMTpNkVi1cg=;
 b=X1gGD79RzYeQUsiAsmahj2YFJSDWl4OOwReBCeUe1HnqvWS/Vz4r+XfUPPScMtwJqg
 pgGugXHjkm+6G5c5svsRe9pUbk10vHRx44z3fqk79UrKnQ2J78iuICbMSzDg19HlgCgH
 Uf7mcFnXhlJdbp8K4nv7PrxJ2eCTyMl0KBgssaoSnRgJuxMAtq8SEkpt6PNLq06lBwF1
 U4bKHaHDo8ouwCQbxrcKNufkcOO4XMEXLY23vq7Npl3nuy5SyNRGjhzmjIDzJqZde7hh
 1jiW1KsJkqG4SvR6O0Xiyv+vndFINTcYkatGPGU7sS+/dY2wX1EvqU/R1qgY142ZTooY
 tORQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwKGOqGm9H+e2wy2qttqqqDesBV2/tLqHUJWZ3Ybqx2p2G+AtrmKa+zBhCkF+SdyzvLuwg7ODIT/5D@nongnu.org
X-Gm-Message-State: AFq9FYJkLqPT0Rw60ty7Ssv+vucz91QJfD1XL2EhgG8Ht1tEv7cTPEPz
 /I1kuqsOIgcfnSBxoZLk2tLFxXdJt/N2tkAWW4dq16NVwmxlyA6Po2UaywZ13TZyp8RFzyOQDEz
 mAJS449a348r8DC6EXb4QthkC//QFxBwLJEo2e2tEUXEtcjXRFazDnXzzzw==
X-Gm-Gg: AYBFou0Gmd1NKMvYgDb19H9Lv20bj7VhjYkDr1hC9FrLRcX6tB9IkXtd6KKwHEPwYZO
 0jxO2gk9AUO+CzL+1pKntP9PGfDpf3Hercj6kiuUqHUDgrlIPDvbSXINJpiAUKrQQ0AjPfFSI79
 YedSyeIR5lR2dfrTDGIRxP94XRDjbWIBqj5tnH3vzc7Q0BGH0Gl/8bopdQaeZ1btCkn2H+uXBxu
 m9d+iYRLeje+0dgvn4RitE3r8A8T5hs1nVUVHVNDJRNq4JKoLch+sjrGoRw7xsS66njnQi+vwlt
 txaf+pB5AZ4y0I+zSLFQmDclX4J+Hxk2zif33SxiRv5M9Gr0uWu67g8ObHYTO9/hR6A+hNn5y0C
 vhx/qwpGid6xmYC1ThxYzkFfM6T3g/SMwgAqnw18ai8w7RPrfmigsZtPFi2gm2DQ5dqG5zQ==
X-Received: by 2002:a05:7300:d10b:b0:33c:13a1:84ea with SMTP id
 5a478bee46e88-34f2199d876mr2925031eec.39.1790955902893; 
 Fri, 02 Oct 2026 08:45:02 -0700 (PDT)
X-Received: by 2002:a05:7300:d10b:b0:33c:13a1:84ea with SMTP id
 5a478bee46e88-34f2199d876mr2924994eec.39.1790955902194; 
 Fri, 02 Oct 2026 08:45:02 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14f984e4sm7150887eec.17.2026.10.02.08.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Oct 2026 08:45:01 -0700 (PDT)
Message-ID: <24e1e361-5d4c-42cd-b715-963052aafe43@oss.qualcomm.com>
Date: Fri, 2 Oct 2026 08:45:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Target-aware machine inventory in combined qemu-system
To: luoyonggang@gmail.com, qemu-level <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <CAE2XoE9X99kzBMWBo8rxmRGnT3NysHjf-GffC9X2796GGipUkg@mail.gmail.com>
 <CAE2XoE-_8jpRaPDE+uYYzszT38XpdB8JJJyXg51Z0-GD=4gMsg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE-_8jpRaPDE+uYYzszT38XpdB8JJJyXg51Z0-GD=4gMsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MiBTYWx0ZWRfX1rYVYr3WDJeN
 /NzMRvjQamfsqMjG2gKdP+mYQrXC2Jhi7eb4Htb5za5b4ZLdqAN1IMKZhM7BvT+Kbr+hRhWhH7i
 OGfF2iSg+fAGuobhuLV45UDWnRfCV+c=
X-Authority-Analysis: v=2.4 cv=GqfXaU1C c=1 sm=1 tr=0 ts=6abfd180 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=p0WdMEafAAAA:8 a=zb9-Ps2InYTBjhqMRfwA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: zGzHevCOKaeZZY1rnb5F49VWpjBeBIyw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MiBTYWx0ZWRfX5zC512eEjTu1
 1aVkAhgQ0ELkZhfZMx5Ji5NPKtssje9gsuH9RZ1ugwQe4sSOrlEtxjqspnH7+YOL5r4RmSZPxlq
 C+trkc/hwALAl7NkhTbB63cA3cdQK9UpglpNf4jkXvGyM8h+94UnZReU75lbJtUpW1C0DfMXjUt
 1I3AKi53ylZtSI3E7nN/wCtFG+LbY2iXeBc3gyboW7S5tDPrGcBoo/qSGRQQst/BUKGHOmPF6nY
 Q4Zs5/U+JumeVXPOPjGOnb546wpK1k1kD4ElBa+gX/uS776Ok33ZvqUBZpSTT8df5gDgJTJeE4D
 rJ/A5Ig9clzu5wHC5o9WrdSbSYeJW3h65xTzwS8RS23zkc9GF0eFfxls0GRIzZgR9eKHgH8SpA2
 y16wFg+OTrDD7B4QnfNP6n0WohNTFZmb4mizSCaU9Ump1OguniwjugK4Z/Bc2KqoA7mnvZ9StN3
 4idWqt2wOAQgg6bPrRg==
X-Proofpoint-ORIG-GUID: zGzHevCOKaeZZY1rnb5F49VWpjBeBIyw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020062
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

On 10/2/2026 8:32 AM, Yonggang Luo wrote:
> Now I place this RFC at https://gitlab.com/qemu-project/qemu/-/work_items/4635
> Maybe there would be a better dicuss place if possible.
> 

Let's keep this on the mailing list, thanks.

